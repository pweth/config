{ config, pkgs, ... }:

{
  environment = {
    # Command aliases
    shellAliases = {
      chmod = "chmod -v";
      chown = "chown -v";
      cls = "clear";
      df = "df -h";
      ga = "git add";
      gaa = "git add --all";
      gb = "git branch";
      gc = "git commit";
      gd = "git diff";
      gds = "git diff --staged";
      gg = "git pull";
      gp = "git push";
      gr = "git reset";
      grc = "git commit --amend --no-edit";
      gs = "git status";
      i = "rg";
      ls = "ls -l";
      mkdir = "mkdir -p";
      nano = "nvim";
      pi = "pip install .";
      src = "source";
      ta = "tmux attach || tmux new-session";
      tls = "tmux list-sessions";
      tn = "tmux new-session";
      v = "nvim";
    };

    # Environment variables
    variables = {
      BAT_THEME = "TwoDark";
      EDITOR = "nvim";
      HISTCONTROL = "ignoreboth";
      HISTSIZE = "10000";
      HISTFILESIZE = "10000";
      HISTTIMEFORMAT = "%F %T ";
      TZ = config.time.timeZone;
      TZ_LIST = builtins.concatStringsSep ";" [
        "America/New_York,New York"
        "Europe/London,London"
        "Asia/Kolkata,Hyderabad"
        "Australia/Sydney,Sydney"
      ];
    };
  };
}
