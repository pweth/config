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
    ./tz.nix
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
    duf
    exiftool
    ffmpeg
    file
    gcc
    gh
    gnupg
    go
    gping
    httpie
    jq
    keybase
    killall
    lolcat
    micro
    nmap
    nms
    nodejs
    openssl
    (python3.withPackages (ps: with ps; [
      build
      ipython
      jupyter
      matplotlib
      numpy
      pandas
      pip
      setuptools
    ]))
    ripgrep
    rustup
    sl
    sqlite
    tldr
    unzip
    yt-dlp
    zstd
  ];
}
