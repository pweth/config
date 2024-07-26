/*
* Home manager configuration for CLI programs.
* See ../gui/default.nix for GUI programs.
*/

{ config, pkgs, user, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./htop.nix
    ./neofetch.nix
    ./python.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.05";
  };

  # Remove manual
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home.packages = with pkgs; [
    backblaze-b2
    bottom
    cbonsai
    cloudflared
    cmatrix
    cowsay
    diff-pdf
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
    imagemagick
    lego
    libheif
    lolcat
    minicom
    nmap
    nms
    nodejs
    passage
    picocom
    ripgrep
    rustup
    sl
    speedtest-cli
    sqlite
    termdown
    tldr
    typescript
    valgrind
    yt-dlp
  ];
}
