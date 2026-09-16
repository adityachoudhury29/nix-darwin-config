# Zsh shell configuration — a full port of the previous ~/.zshrc
{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # History options (mirrors your previous .zshrc)
    history = {
      size = 10000;
      path = "/Users/aditya.c.001/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      extended = false;
      expireDuplicatesFirst = true;
      save = 10000;
    };

    shellAliases = {
      # Existing aliases (kept exactly)
      ll = "ls -l";
      rebuild = "sudo darwin-rebuild switch --flake ~/.nix-config#macbook";

      # Haskell Language Server shortcuts
      hls = "haskell-language-server-wrapper";
      haskell-language-server = "haskell-language-server-wrapper";

      # Extra useful ones
      grep = "grep --color=auto";
    };

    initContent = ''
      # History options (mirrored from the old ~/.zshrc; some options are
      # set here because oh-my-zsh/compinit reset them otherwise)
      HISTSIZE="10000"
      SAVEHIST="10000"

      HISTFILE="/Users/aditya.c.001/.zsh_history"
      mkdir -p "$(dirname "$HISTFILE")"

      setopts=(
        HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
        NO_APPEND_HISTORY NO_EXTENDED_HISTORY NO_HIST_EXPIRE_DUPS_FIRST
        NO_HIST_FIND_NO_DUPS NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS
      )
      for opt in "''${setopts[@]}"; do
        setopt "$opt"
      done
      unset opt setopts
    '';
  };

  # Starship prompt (your prior setup used it; the config file in ~/.config is
  # preserved automatically via backupFileExtension)
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    # Uses the existing ~/.config/starship.toml if present, unchanged.
    # Add `settings = { ... }` here to generate a config file.
  };

  # Direnv — auto-loads developer environments per folder
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}