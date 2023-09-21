/*
* Bourne Again SHell configuration.
*/

{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    # History
    historyControl = [ "ignoredups" ];
    historyFileSize = 15000;
    historySize = 10000;
    shellOptions = [ "histappend" ];

    # Command aliases
    shellAliases = {
      cls = "clear";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gp = "git push";
      gs = "git status";
      ll = "ls -aFhl";
      rb = "sudo nixos-rebuild switch --flake /home/pweth/dotfiles";
      rbi = "sudo nixos-rebuild switch --flake /home/pweth/dotfiles --impure";
      v = "nvim"; 
    };
  };
}
