{
  description = "Aditya's macOS system flake (nix-darwin + home-manager)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manages Homebrew itself so casks not in nixpkgs can still be installed
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      ...
    }@inputs:
    let
      user = "aditya.c.001";
      system = "aarch64-darwin";
    in
    {
      darwinConfigurations."macbook" = darwin.lib.darwinSystem {
        inherit system;

        # `inputs` is passed so home-manager modules can reference other inputs if needed.
        specialArgs = {
          inherit self user system inputs;
        };

        modules = [
          ./hosts/macbook

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Migrate the existing brew installation under nix-homebrew's control
              autoMigrate = true;
              user = "${user}";
            };
          }

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              # Use the same nixpkgs (with allowUnfree) as the system
              useGlobalPkgs = true;
              useUserPackages = true;
              # Preserve any dotfile Nix is about to replace
              backupFileExtension = "backup";
              # Pass inputs to home-manager modules (if any module needs them)
              extraSpecialArgs = { inherit inputs; };
              users.${user} = import ./home/users/${user};
            };
          }
        ];
      };
    };
}