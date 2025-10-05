/*
  * Home manager configuration for CLI programs.
  * See ../gui for GUI programs.
*/

{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./htop.nix
    ./key-files.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "pweth";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    backblaze-b2
    bitwarden-cli
    cloudflared
    cmatrix
    cowsay
    diff-pdf
    exiftool
    ffmpeg
    go
    httpie
    hwatch
    imagemagick
    immich-cli
    lego
    libheif
    lolcat
    mitmproxy
    multitime
    nixfmt-rfc-style
    nmap
    nms
    passage
    python3
    ripgrep
    sl
    speedtest-cli
    sqlite
    termdown
    yt-dlp
  ];
}
