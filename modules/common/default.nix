# Common nix-darwin configuration shared across hosts (only one host today).
{ config, pkgs, lib, ... }:

{
  imports = [
    ./nix-settings.nix
    ./users.nix
  ];
}