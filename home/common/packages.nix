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

    # NOTE (2026-09): `haskell-language-server` is intentionally NOT installed
    # globally. A global HLS build (from this flake's nixpkgs) has a DIFFERENT
    # `ghc-9.6.7` than our Haskell projects' flakes, so it fails at startup with
    # "GHC ABIs don't match!". HLS must come from the SAME GHC package set as the
    # project — see `log-processor/devshell.nix` (adds HLS to the devshell).

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