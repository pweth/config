/*
* Bourne Again Shell configuration.
*/

{ config, ... }:

{
  programs.bash = {
    enable = true;

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
      tka = "tmux kill-session -a";
      tls = "tmux ls";
      v = "nvim"; 
    };

    # Functions
    initExtra = ''
      weather() { curl -s "wttr.in/''${1}" | head -n -1; }
    '';
  };
}
