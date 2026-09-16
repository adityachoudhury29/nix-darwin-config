# GUI applications installed as Nix packages.
# These show up in /Applications/Nix Apps/ (via environment.pathsToLink).
{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Browsers
    google-chrome

    # Editors / IDEs
    vscode
    ghostty-bin # prebuilt macOS Ghostty (nixpkgs `ghostty` is Linux-only)

    # Terminals
    iterm2

    # Communication
    slack

    # Development infrastructure (GUI)
    podman-desktop
  ];
}