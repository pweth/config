/*
* Common system configuration across all hosts.
*/

{ config, pkgs, agenix, hostName, host, ... }:

{
  imports = [
    ./cloudflared.nix
    ./docker.nix
    ./exporter.nix
    ./fonts.nix
    ./impermanence.nix
    ./locale.nix
    ./nextdns.nix
    ./security.nix
    ./tailscale.nix
    ./user.nix
  ];

  # NixOS release version
  system.stateVersion = "23.11";

  # Remove NixOS manual
  documentation.nixos.enable = false;

  # Environment variables
  environment.sessionVariables = {
    BAT_THEME = "TwoDark";
    EDITOR = "nvim";
    HISTCONTROL = "ignoreboth";
    HISTSIZE = "10000";
    HISTFILESIZE = "15000";
    HISTTIMEFORMAT = "%F %T ";
    MINICOM = "-con";
    TZ_LIST = builtins.concatStringsSep ";" [
      "America/New_York,New York"
      "Europe/London,London"
      "Asia/Kolkata,Hyderabad"
      "Australia/Sydney,Sydney"
    ];
  };

  # System packages
  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ] ++ (with pkgs; [
    age
    age-plugin-yubikey
    bat
    curl
    dig
    duf
    eza
    file
    fzf
    git
    htop
    inetutils
    jq
    killall
    neofetch
    neovim
    openssl
    p7zip
    rclone
    ripgrep
    tldr
    tmux
    tree
    tz
    unzip
    usbutils
    wget
    zip
  ]);

  # Home manager
  home-manager = {
    extraSpecialArgs.host = host;
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pweth = import ../home/cli;
  };

  # Hostname
  networking.hostName = hostName;

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Automatic `nix store optimise`
  nix.settings.auto-optimise-store = true;

  # Nix subcommands and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable fuzzy finder
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };
}
