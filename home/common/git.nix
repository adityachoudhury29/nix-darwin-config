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
      # Systemwide identity: Juspay work email. Auth to GitHub is via the
      # keychain PAT, separate from commit identity — pushes to the personal
      # adityachoudhury29 repos still work.
      user = {
        name = "Aditya Choudhury";
        email = "aditya.c.001@juspay.in";
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      core.editor = "code --wait";
      core.hooksPath = "/etc/git-guardian/hooks"; # gitleaks pre-push hook (company requirement)
      merge.tool = "nvimdiff";
    };

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