# User definition.
# The user's home-manager configuration lives in home/users/<name>.
{
  config,
  pkgs,
  lib,
  ...
}:
let
  user = "aditya.c.001";
in
{
  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };
}