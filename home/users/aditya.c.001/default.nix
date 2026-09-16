# Home configuration for user 'aditya.c.001'
{ config, pkgs, lib, ... }:

{
  imports = [
    ../../common
    ./packages.nix
  ];

  home.username = "aditya.c.001";
  home.homeDirectory = "/Users/aditya.c.001";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home Manager state version. Use the CURRENT release you manage with —
  # this flake runs unstable, which is at/above 26.11. Do NOT downgrade below 26.05.
  home.stateVersion = "26.11";
}