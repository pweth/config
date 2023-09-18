/*
* Personal laptop system configuration.
*/

{ config, pkgs, home-manager, agenix, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # Networking
  networking = {
    hostName = "emperor";
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager.dns = "none";
    networkmanager.enable = true;
  };

  # Sound and Bluetooth
  sound.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # Load in agenix secrets
  environment.systemPackages = [
    agenix.packages.x86_64-linux.default
  ];
  age.identityPaths = [ "/home/pweth/.ssh/id_ed25519" ];
  age.secrets.duckduckgo-api-key.file = ../../secrets/duckduckgo-api-key.age;
  age.secrets.password-hash.file = ../../secrets/password-hash.age;

  # User account
  users.users.pweth = {
    description = "Peter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    passwordFile = config.age.secrets.password-hash.path;
  };

  # Home manager
  home-manager.users.pweth = import ../../home/pweth;

  # System services
  services.keybase.enable = true;
  services.printing.enable = true;

  # Enable ClamAV daemon and automatic `freshclam`
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # NextDNS proxy (DNS-over-HTTPS)
  services.nextdns = {
    enable = true;
    arguments = [ "-profile" "ffa426" ];
  };
}
