/*
* Common system configuration across all hosts.
*/

{ config, pkgs, home-manager, ... }:

{
  # Environment variables
  environment.sessionVariables = {
    EDITOR = "micro";
    HISTTIMEFORMAT = "%F %T ";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    curl
    dig
    git
    htop
    micro
    nano
    neofetch
    tree
    vim
    wget
  ];

  # Home manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.pweth = import ../../home;

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

  # Enable ClamAV daemon and automatic `freshclam`
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

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
