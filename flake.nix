{
  description = "macOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, nix-homebrew, home-manager, ... }:
    let
      user = "aditya.c.001";
      system = "aarch64-darwin";
    in {
    darwinConfigurations."macbook" = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            git
            neovim
            ghc
            cabal-install
            stack
            haskell-language-server
          ];

          # Explicitly define the user and home directory
          users.users.${user} = {
            name = "${user}";
            home = "/Users/${user}";
          };

          programs.zsh.enable = true;
          nix.enable = false;
	  # Allow your user to use extra substituters/binary caches
          nix.settings.trusted-users = [ "root" "aditya.c.001" ];

          system.stateVersion = 4;
          system.primaryUser = "${user}";
          
          homebrew = {
            enable = true;
            onActivation.cleanup = "zap";
            casks = [
              "google-chrome"
              "visual-studio-code"
            ];
          };
        })

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            autoMigrate = true;
            user = "${user}";
          };
        }

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = { pkgs, ... }: {
            home.stateVersion = "24.05";
            
            # Zsh plugins and aliases
            programs.zsh = {
              enable = true;
              enableCompletion = true;
              autosuggestion.enable = true;
              syntaxHighlighting.enable = true;
              shellAliases = {
                ll = "ls -l";
                rebuild = "sudo darwin-rebuild switch --flake ~/.nix-config#macbook";

                # Haskell Language Server shortcuts
                hls = "haskell-language-server-wrapper";
                haskell-language-server = "haskell-language-server-wrapper";
              };
            };

            # Terminal Theme
            programs.starship = {
              enable = true;
              enableZshIntegration = true;
            };

            # Auto-loads developer environments per folder
            programs.direnv = {
              enable = true;
              enableZshIntegration = true;
              nix-direnv.enable = true;
            };
          };
        }
      ];
    };
  };
}
