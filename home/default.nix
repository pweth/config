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
    exiftool
    ffmpeg
    file
    gcc
    gh
    gnumake
    gnupg
    go
    gping
    httpie
    jq
    keybase
    killall
    lolcat
    nano
    netpbm
    nmap
    nms
    nodejs
    openssl
    (python3.withPackages (ps: with ps; [
      build
      gensim
      ipython
      jupyter
      matplotlib
      nltk
      numpy
      pandas
      pip
      scikit-learn
      setuptools
      spacy
    ]))
    ripgrep
    rustup
    sl
    sqlite
    tldr
    unzip
    yt-dlp
    zip
  ];
}
