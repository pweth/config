{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./firefox.nix
    ./git.nix
    ./gnome.nix
    ./starship.nix
    ./tz.nix
    ./vscode.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";

    # User packges not imported as modules
    packages = with pkgs; [
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
  };
}
