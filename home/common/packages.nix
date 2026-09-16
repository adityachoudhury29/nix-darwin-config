# CLI tools installed via Home Manager (user-level, available in every shell)
{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    # --- Modern shell tools ---
    eza
    zoxide
    fzf
    bat
    ripgrep
    fd
    zellij
    tmux
    lazygit

    # --- Haskell toolchain (from your previous config) ---
    ghc
    cabal-install
    stack
    haskell-language-server

    # --- Misc ---
    jq
    starship
    direnv
    nix-direnv
    gh
    git
    htop
    fastfetch
  ];
}