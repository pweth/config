{ config, pkgs, ... }:

{
  imports = [
    ./dconf.nix
    # ./firefox.nix
    ./git.nix
  ];

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;
}
