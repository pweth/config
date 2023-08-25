{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Set username and user email
    userName = "pweth";
    userEmail = "22416843+pweth@users.noreply.github.com";

    # Use the difftastic syntax highlighter
    difftastic.enable = true;
    difftastic.color = "always";
  };
}
