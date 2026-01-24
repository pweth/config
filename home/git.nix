# * Git configuration.

{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      advice.addIgnoredFile = false;
      column.ui = "auto";
      commit.verbose = true;
      core.editor = "nvim";
      credential.helper = "store";
      diff.sqlite3 = {
        binary = true;
        textconv = "echo .dump | sqlite3";
      };
      help.autoCorrect = -1;
      http.postBuffer = 157286400;
      init.defaultBranch = "main";
      log = {
        decorate = "short";
        follow = true;
      };
      rebase.stat = true;
      user = {
        name = config.home.username;
        email = "22416843+pweth@users.noreply.github.com";
      };
    };
  };
}
