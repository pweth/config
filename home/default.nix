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
    ./python.nix
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
    gh
    gnumake
    gnupg
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
    nixos-anywhere
    nmap
    nms
    passage
    ripgrep
    sl
    speedtest-cli
    sqlite
    sshfs
    termdown
    yt-dlp
  ];
}
