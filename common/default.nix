/*
* Common system configuration across all hosts.
*/

{ config, pkgs, agenix, ... }:

{
  # Environment variables
  environment.sessionVariables = {
    BAT_THEME = "TwoDark";
    EDITOR = "nvim";
    HISTCONTROL = "ignoredups";
    HISTSIZE = "10000";
    HISTFILESIZE = "15000";
    HISTTIMEFORMAT = "%F %T ";
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
    bat
    curl
    dig
    duf
    eza
    file
    fzf
    git
    htop
    neofetch
    neovim
    openssl
    rclone
    tmux
    tree
    tz
    wget
  ]);

  # Fonts
  fonts = {
    packages = with pkgs; [
      hack-font
      noto-fonts
      noto-fonts-emoji
    ];
    fontconfig.defaultFonts = {
      serif = [ "NotoSerif" ];
      sansSerif = [ "NotoSans" ];
      monospace = [ "Hack" ];
    };
  };

  # UK locale settings
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
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

  # Enable fuzzy finder
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

  # NextDNS proxy (DNS-over-HTTPS)
  age.secrets.nextdns.file = ../secrets/nextdns.age;
  systemd.services.nextdns = {
    environment.SERVICE_RUN_MODE = "1";
    startLimitBurst = 10;
    startLimitIntervalSec = 5;
    serviceConfig = {
      EnvironmentFile = config.age.secrets.nextdns.path;
      ExecStart = builtins.concatStringsSep " " [
        "${pkgs.nextdns}/bin/nextdns run -profile"
        "\${PROFILE}/${config.networking.hostName}"
      ];
      RestartSec = 120;
      LimitMEMLOCK = "infinity";
    };
    after = [ "network.target" "run-agenix.d.mount" ];
    before = [ "nss-lookup.target" ];
    wants = [ "nss-lookup.target" "run-agenix.d.mount" ];
    wantedBy = [ "multi-user.target" ];
  };

  # NixOS release version
  system.stateVersion = "23.11";

  # Set time zone to London
  time.timeZone = "Europe/London";

  # User account
  users.users.pweth = {
    description = "Peter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg"
    ];
  };

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;
}
