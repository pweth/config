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

  # User account
  users.users.pweth = {
    description = "Peter";
    extraGroups = [
      "wheel"
    ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg"
    ];
  };
}
