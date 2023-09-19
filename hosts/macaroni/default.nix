/*
* Oracle Cloud VM system configuration.
*/

{ config, pkgs, agenix, ... }:

{
  imports = [
    ./hardware.nix
    ../../containers
  ];

  # agenix
  environment.systemPackages = [
    agenix.packages.aarch64-linux.default
  ];

  # Networking
  networking = {
    hostName = "macaroni";
    nameservers = [ "1.1.1.3" "1.0.0.3" ];
  };

  # Secure Shell
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  # Enable Docker
  virtualisation.docker.enable = true;
}
