{ config, pkgs, ... }:

{
  imports = [
    ../../packages/bash.nix
    ../../packages/firefox.nix
    ../../packages/git.nix
    ../../packages/gnome.nix
    ../../packages/starship.nix
    ../../packages/tz.nix
    ../../packages/vscode.nix
  ];

  # User packges not imported as modules
  home.packages = with pkgs; [
    age
    appimage-run
    bitwarden
    cmatrix
    cowsay
    duf
    emote
    exiftool
    ffmpeg
    file
    gcc
    gh
    gimp
    gnupg
    go
    gping
    httpie
    jq
    keybase
    killall
    libreoffice
    lolcat
    micro
    nmap
    nms
    nodejs
    obsidian
    openssl
    pipes
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
    spotify
    sqlite
    sqlitebrowser
    tldr
    tz
    vlc
    yt-dlp
  ];
}
