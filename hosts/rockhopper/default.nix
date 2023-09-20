/*
* Raspberry Pi system configuration.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # Bootloader
  boot.loader = {
    grub.enable = true;
    generic-extlinux-compatible.enable = true;
  };

  # Networking
  networking = {
    hostName = "rockhopper";
    nameservers = [ "1.1.1.3" "1.0.0.3" ];
  };

  # Secure Shell
  services.openssh = {
    enable = true;
    # TMP
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

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
}
