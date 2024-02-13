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
    ./starship.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home.packages = with pkgs; [
    age
    age-plugin-yubikey
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
    inetutils
    jq
    killall
    libheif
    lolcat
    minicom
    nmap
    nms
    nodejs
    picocom
    p7zip
    ripgrep
    rustup
    sl
    speedtest-cli
    sqlite
    tldr
    typescript
    unzip
    usbutils
    valgrind
    yt-dlp
    zip
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
