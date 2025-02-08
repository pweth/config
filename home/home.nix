/*
* Home manager configuration for CLI programs.
* See ../gui/home.nix for GUI programs.
*/

{ config, pkgs, user, version, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./htop.nix
    ./key-files.nix
    ./python.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = version;
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
    dasel
    diff-pdf
    dive
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
    hwatch
    imagemagick
    immich-cli
    lego
    libheif
    lolcat
    mitmproxy
    multitime
    nmap
    nms
    nodejs
    passage
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
