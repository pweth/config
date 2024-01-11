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
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/pweth";
    stateVersion = "22.11";
  };

  home.packages = with pkgs; [
    age
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
      matplotlib
      numpy
      pandas
      pygments
      pytest
      requests
      rich
      setuptools
    ]))
  ];

  # Disable help manuals
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
