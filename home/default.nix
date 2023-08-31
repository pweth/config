{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
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
    file.".face".source = ../assets/profile.png;

    # Environment variables
    sessionVariables = {
      EDITOR = "micro";
      HISTTIMEFORMAT = "%F %T ";
      TZ_LIST = "America/New_York,New York;Europe/London,London;Australia/Sydney,Sydney";
    };

    # User packges not imported as modules
    packages = with pkgs; [
      bitwarden
      cmatrix
      cowsay
      duf
      exiftool
      ffmpeg
      file
      gcc
      gh
      gimp
      gping
      go
      httpie
      jq
      keybase
      libreoffice
      librewolf
      lolcat
      micro
      neofetch
      nmap
      nms
      nodejs
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
      tmpmail
      tz
      vlc
      yt-dlp
    ];
  };
}
