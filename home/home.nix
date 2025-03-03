/*
  * Home manager configuration for CLI programs.
  * See ../gui/home.nix for GUI programs.
*/

{
  config,
  pkgs,
  user,
  version,
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
    bitwarden-cli
    cloudflared
    cmatrix
    cowsay
    diff-pdf
    exiftool
    ffmpeg
    gdb
    gh
    gnumake
    gnupg
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
    ripgrep
    sl
    speedtest-cli
    sqlite
    sshfs
    termdown
    yt-dlp
  ];
}
