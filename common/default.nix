# * Common system configuration across all hosts.

{
  config,
  lib,
  pkgs,
  agenix,
  host,
  version,
  ...
}:

{
  imports = [
    ./fonts.nix
    ./locale.nix
    ./nginx.nix
    ./security.nix
    ./user.nix
  ];

  # Release version
  system.stateVersion = version;

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
    TZ = config.time.timeZone;
    TZ_LIST = builtins.concatStringsSep ";" [
      "America/New_York,New York"
      "Europe/London,London"
      "Asia/Kolkata,Hyderabad"
      "Australia/Sydney,Sydney"
    ];
  };

  # System packages
  environment.systemPackages =
    [ agenix.packages."${pkgs.system}".default ]
    ++ (with pkgs; [
      age
      age-plugin-yubikey
      bat
      curl
      dig
      duf
      eza
      fastfetch
      file
      fzf
      gawk
      gcc
      git
      htop
      inetutils
      jq
      neovim
      networkmanager
      ncdu
      openssl
      p7zip
      rclone
      restic
      screen
      tmux
      tree
      tz
      unzip
      usbutils
      wget
      xclip
      zip
    ]);

  # Networking
  networking = {
    hostName = host.name;
    useDHCP = lib.mkDefault true;
  };

  # Nix settings
  nix = {
    gc.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "pweth" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Platform
  nixpkgs.hostPlatform = lib.mkDefault host.architecture;

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

  # Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
