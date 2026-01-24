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
    ./networking.nix
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
      backblaze-b2
      bat
      btop
      bubblewrap
      cloudflared
      cmatrix
      coreutils
      cowsay
      curl
      diff-pdf
      dig
      exiftool
      fastfetch
      ffmpeg
      file
      fzf
      gawk
      gcc
      gdb
      gh
      git
      gnumake
      gnupg
      go
      htop
      httpie
      imagemagick
      immich-cli
      inetutils
      jq
      lego
      libheif
      lolcat
      lsof
      mitmproxy
      multitime
      ncdu
      neovim
      nethogs
      networkmanager
      nixfmt-rfc-style
      nixos-anywhere
      nix-tree
      nmap
      nms
      openssl
      p7zip
      passage
      pciutils
      python3
      rclone
      restic
      ripgrep
      screen
      sl
      speedtest-cli
      sqlite
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
      yt-dlp
      zip
    ]);

  # Nix settings
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
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

  # Limit boot entries
  boot.loader.systemd-boot.configurationLimit = 5;

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
}
