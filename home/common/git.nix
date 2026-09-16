# Git configuration
{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Aditya Choudhury";
        email = "achoudhury2004@gmail.com"; # GitHub account that owns this repo
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      core.editor = "code --wait";
      core.hooksPath = "/etc/git-guardian/hooks"; # gitleaks pre-push hook (company requirement)
      merge.tool = "nvimdiff";

      # Work repos (Bitbucket / @juspay.in) can override the personal identity
      # via a per-repo git config. For example, inside a work checkout:
      #   git config user.name "Aditya"
      #   git config user.email "aditya.c.001@juspay.in"
      # Or point git at a dedicated work gitconfig (see `includes` below).
    };

    # Add an unconditional include for a work gitconfig, if you create one:
    # includes = [ { path = "~/work.gitconfig"; } ];

    ignores = [
      ".DS_Store"
      "*.swp"
      "*.swo"
      "*~"
      ".direnv/"
      "result"
      "result-*"
    ];
  };

  # GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
}