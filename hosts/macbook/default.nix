# macbook - Aditya's Apple Silicon MacBook
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./system.nix
    ./gui-apps.nix
    ./homebrew.nix
    ./system-defaults.nix
    ../../modules/common
  ];

  # Allow unfree packages (chrome, vscode, slack, etc.)
  nixpkgs.config.allowUnfree = true;

  # Hostname
  networking.hostName = "macbook";
  networking.computerName = "Aditya's MacBook";

  # System state version - keep it at the version you had; bump only on upgrade
  system.stateVersion = 4;

  # Primary user for nix-darwin
  system.primaryUser = "aditya.c.001";
}