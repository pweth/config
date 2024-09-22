/*
* Common system configuration across all hosts.
*/

{ config, pkgs, agenix, domain, host, keys, user, ... }:

{
  imports = [
    ./fonts.nix
    ./impermanence.nix
    ./locale.nix
    ./nextdns.nix
    ./nginx.nix
    ./security.nix
    ./tailscale.nix
    ./user.nix
  ];

  # Release version
  system.stateVersion = "24.05";

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
    gawk
    git
    inetutils
    jq
    killall
    neovim
    networkmanager
    openssl
    p7zip
    rclone
    restic
    tmux
    tree
    tz
    unzip
    usbutils
    wget
    xclip
    zip
  ]);

  # Home manager
  home-manager = {
    extraSpecialArgs = {
      domain = domain;
      host = host;
      keys = keys;
      user = user;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${user}" = import ../home/cli;
  };

  # Networking
  networking = {
    hostName = host.name;
    nameservers = [ "127.0.0.1" ];
  };

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

  # Fuzzy finder
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

  # Node exporter
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
    port = 12345;
  };
}
