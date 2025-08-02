# * Git configuration.

{ config, ... }:

{
  programs.git = {
    enable = true;

    # Set username and user email
    userName = config.home.username;
    userEmail = "22416843+pweth@users.noreply.github.com";

    # Use the difftastic syntax highlighter
    difftastic = {
      enable = true;
      color = "always";
    };

    # Additional configuration
    extraConfig = {
      advice.addIgnoredFile = false;
      column.ui = "auto";
      commit.verbose = true;
      core.editor = "nvim";
      credential.helper = "store";
      diff.sqlite3 = {
        binary = true;
        textconv = "echo .dump | sqlite3";
      };
      difftastic = {
        enable = true;
        color = "always";
      };
      help.autoCorrect = -1;
      http.postBuffer = 157286400;
      init.defaultBranch = "main";
      log = {
        decorate = "short";
        follow = true;
      };
      rebase.stat = true;
    };
  };
}
