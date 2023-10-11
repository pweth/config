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
      ls = "exa -la";
      rb = "sudo nixos-rebuild switch --flake /home/pweth/dotfiles";
      rbi = "sudo nixos-rebuild switch --flake /home/pweth/dotfiles --impure";
      v = "nvim"; 
    };

    # Functions
    initExtra = ''
      weather() { curl -s "wttr.in/''${1}" | head -n -1; }
    '';
  };
}
