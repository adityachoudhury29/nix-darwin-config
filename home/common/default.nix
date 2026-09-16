# Common home-manager configuration shared by all users.
{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./git.nix
    ./packages.nix
  ];
}