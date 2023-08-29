{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./git.nix
    ./gnome.nix
    ./vscode.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";

    # Dotfiles
    file.".bashrc".source = ../assets/bashrc;
    file.".face".source = ../assets/profile.png;
    file.".config/news-flash/newsflash_gtk.json".source = ../assets/newsflash.json;

    # User packges not imported as modules
    packages = with pkgs; [
      bitwarden
      cmatrix
      cowsay
      duf
      exiftool
      ffmpeg
      gcc
      gh
      gimp
      gping
      go
      htop
      httpie
      jq
      keybase
      libreoffice
      librewolf
      lolcat
      micro
      neofetch
      newsflash
      nmap
      nms
      nodejs
      openssl
      pipes
      (python3.withPackages (ps: with ps; [
        ipython
        jupyter
        matplotlib
        numpy
        pandas
        setuptools
      ]))
      ripgrep
      rustup
      sl
      spotify
      tldr
      tmpmail
      vlc
      yt-dlp
    ];
  };
}
