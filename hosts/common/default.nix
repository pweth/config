/*
* Common system configuration across all hosts.
*/

{ config, pkgs, home-manager, agenix, ... }:

{
  # Use the systemd-boot EFI boot loader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Set time zone to London
  time.timeZone = "Europe/London";

  # System packages
  environment.systemPackages = with pkgs; [
    agenix.packages.x86_64-linux.default
    curl
    git
    htop
    nano
    tree
    vim
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
}
