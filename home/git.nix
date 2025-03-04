# * Git configuration.

{ config, user, ... }:

{
  programs.git = {
    enable = true;

    # Set username and user email
    userName = user;
    userEmail = "22416843+pweth@users.noreply.github.com";

    # Use the difftastic syntax highlighter
    difftastic = {
      enable = true;
      color = "always";
    };

    # Additional configuration
    extraConfig = {
      advice.addIgnoredFile = false;
      core.editor = "nvim";
      credential.helper = "store";
      diff.sqlite3 = {
        binary = true;
        textconv = "echo .dump | sqlite3";
      };
      http.postBuffer = 157286400;
      init.defaultBranch = "main";
    };
  };
}
