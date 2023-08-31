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
      ll = "ls -aFhl";
      rb = "sudo nixos-rebuild switch --flake /home/pweth/dotfiles";
      rbi = "sudo nixos-rebuild switch --flake /home/pweth/dotfiles --impure";
    };
  };
}