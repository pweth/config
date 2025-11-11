/*
  * Home manager configuration for CLI programs.
  * See ../gui for GUI programs.
*/

{ config, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./key-files.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.11";
  };
}
