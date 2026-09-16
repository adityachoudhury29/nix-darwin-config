# System-level configuration: nix settings, shell, keyboard, system packages.
{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Shells available to the system (also used by user.shell below)
  environment.shells = with pkgs; [ zsh ];

  # Make GUI apps installed via Nix appear in Spotlight (/Applications/Nix Apps/)
  environment.pathsToLink = [ "/Applications" ];

  # Path order: brew first (so brew-managed binaries still win), then nix.
  environment.systemPath = [ "/opt/homebrew/bin" ];

  # System-wide CLI packages (user-level tools live in home/common/packages.nix)
  environment.systemPackages = with pkgs; [
    git
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Fonts - used by terminal/IDE configurations
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.symbols-only
  ];
}