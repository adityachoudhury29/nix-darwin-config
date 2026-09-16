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
    };

    # Work repos under ~/Desktop (Juspay Bitbucket) use the work identity.
    includes = [
      {
        condition = "gitdir:~/Desktop/";
        contents = {
          user = {
            name = "Aditya Choudhury";
            email = "aditya.c.001@juspay.in";
          };
        };
      }
    ];

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