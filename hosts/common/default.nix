/*
* Common system configuration across all hosts.
*/

{ config, pkgs, ... }:

{
  # Environment variables
  environment.sessionVariables = {
    EDITOR = "nvim";
    HISTCONTROL = "ignoredups";
    HISTSIZE = "10000";
    HISTFILESIZE = "15000";
    HISTTIMEFORMAT = "%F %T ";
    TZ_LIST = "America/New_York;Europe/London;Australia/Sydney";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    bat
    curl
    dig
    duf
    exa
    git
    htop
    neofetch
    neovim
    tmux
    tree
    tz
    wget
  ];

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

  # NixOS release version
  system.stateVersion = "23.05";

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
  age.secrets.password-hash.file = ../../secrets/password-hash.age;
  users.users.pweth.passwordFile = config.age.secrets.password-hash.path;
}
