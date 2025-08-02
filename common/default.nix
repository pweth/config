# * Common system configuration across all hosts.

{
  config,
  lib,
  pkgs,
  agenix,
  host,
  ...
}:

{
  imports = [
    ./i18n.nix
    ./security.nix
    ./user.nix
  ];

  # Original release version
  system.stateVersion = "24.11";

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
      gdb
      git
      htop
      inetutils
      jq
      lsof
      ncdu
      neovim
      networkmanager
      nixos-anywhere
      openssl
      p7zip
      pciutils
      rclone
      restic
      rr
      screen
      sshfs
      strace
      tmux
      tree
      tz
      unzip
      usbutils
      valgrind
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
        "flakes"
        "nix-command"
        "pipe-operators"
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

  # Reverse proxy
  services.nginx = {
    enable = true;
    clientMaxBodySize = "0";
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedZstdSettings = true;

    # Virtual host
    virtualHosts."${host.name}.pweth.com" = {
      forceSSL = true;
      locations."/".proxyPass =
        "http://localhost:${builtins.toString config.services.prometheus.exporters.node.port}";
      sslCertificate = ../static/pweth.crt;
      sslCertificateKey = config.age.secrets.certificate.path;
    };
  };

  # Node exporter
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
    port = 12345;
  };

  # Tailscale
  services.tailscale.enable = true;
}
