# User-specific packages (in addition to home/common/packages.nix)
{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # User-level extras go here
  ];
}