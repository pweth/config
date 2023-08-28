{ config, pkgs, ... }:

{
  imports = [
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
      go
      htop
      httpie
      jq
      libreoffice
      librewolf
      lolcat
      micro
      neofetch
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
      vlc
      youtube-dl
    ];

    # Create .face file
    file.".face".source = ../assets/profile.png;
  };
}
