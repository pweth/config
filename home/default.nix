/*
* Home manager configuration for CLI programs.
* See ./gui.nix for GUI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./cowyodel.nix
    ./git.nix
    ./htop.nix
    ./neofetch.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";
  };

  # Remove manual
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home.packages = with pkgs; [
    backblaze-b2
    cloudflared
    cmatrix
    cowsay
    exiftool
    ffmpeg
    fortune
    gcc
    gdb
    gh
    gnumake
    gnupg
    go
    home-manager
    httpie
    libheif
    lolcat
    minicom
    nmap
    nms
    nodejs
    picocom
    rustup
    sl
    speedtest-cli
    sqlite
    typescript
    valgrind
    yt-dlp
  ] ++ [
    (python3.withPackages (ps: with ps; [
      arrow
      jupyter
      matplotlib
      nltk
      notebook
      numpy
      opencv4
      pandas
      pip
      pygments
      pyjwt
      pytest
      pyzmq
      requests
      rich
      scikit-learn
      setuptools
      virtualenv
    ]))
  ];
}
