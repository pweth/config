/*
* Git CLI tool configuration.
*/

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Set username and user email
    userName = "pweth";
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
      init.defaultBranch = "main";
    };
  };
}
