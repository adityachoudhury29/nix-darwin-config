# User-specific packages (in addition to home/common/packages.nix)
{ config, pkgs, lib, ... }:

{
  # NOTE: do NOT add a `haskell-language-server` here. HLS is GHC-version- AND
  # GHC-build-specific: a global HLS built from this flake's nixpkgs will NOT
  # match the ghc our Haskell project flakes use ("GHC ABIs don't match!" at
  # HLS startup). Install HLS per-repo via each repo's devshell instead.
  # See home/common/packages.nix NOTE.
  home.packages = with pkgs; [
    # User-level extras go here
  ];
}