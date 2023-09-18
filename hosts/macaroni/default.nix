/*
* Oracle Cloud VM system configuration.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
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

  # Home manager
  home-manager.users.pweth = import ./home.nix;

  # Enable Docker
  virtualisation.docker.enable = true;
}
