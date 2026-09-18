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

    # --- Nix tooling ---
    nil               # Nix language server (LSP) for editors
    nixfmt-rfc-style  # official RFC-style Nix formatter

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