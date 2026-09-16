# Homebrew via nix-homebrew.
# Only casks that are NOT available in nixpkgs should be listed here.
# Everything else lives in Nix (gui-apps.nix, system.nix, home/...).
{
  pkgs,
  lib,
  ...
}:

{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    # Taps are managed by nix-homebrew via autoMigrate; you rarely need this.
    taps = [ ];

    # CLI tools that have no nixpkgs equivalent (rare).
    # e.g. "gitleaks"
    brews = [ ];

    # GUI casks not present in nixpkgs. Only add here what you cannot find in
    # nixpkgs. Verified present in nixpkgs already: chrome, vscode, slack,
    # ghostty, iterm2, podman-desktop → keep them in gui-apps.nix instead.
    casks = [ ];
  };
}