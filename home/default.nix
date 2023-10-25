/*
* Home manager configuration for CLI programs.
* See ./gui.nix for GUI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./starship.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";
  };

  home.packages = with pkgs; [
    age
    cmatrix
    cowsay
    exiftool
    ffmpeg
    file
    gcc
    gdb
    gh
    gnumake
    gnupg
    go
    httpie
    jq
    keybase
    killall
    lolcat
    nano
    nmap
    nms
    nodejs
    openssl
    python3
    ripgrep
    rustup
    sl
    sqlite
    tldr
    unzip
    valgrind
    yt-dlp
    zip
  ];
}
