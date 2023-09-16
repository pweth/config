{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./firefox.nix
    ./git.nix
    ./gnome.nix
    ./starship.nix
    ./vscode.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";

    # GNOME profile picture
    file.".face".source = ../static/profile.png;

    # Environment variables
    sessionVariables = {
      EDITOR = "micro";
      HISTTIMEFORMAT = "%F %T ";
      TZ_LIST = "America/New_York;Europe/London;Australia/Sydney";
    };

    # User packges not imported as modules
    packages = with pkgs; [
      age
      appimage-run
      bitwarden
      cmatrix
      cowsay
      dig
      duf
      emote
      exiftool
      ffmpeg
      file
      gcc
      gh
      gimp
      gnupg
      gping
      go
      httpie
      jq
      keybase
      killall
      libreoffice
      librewolf
      lolcat
      micro
      neofetch
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
