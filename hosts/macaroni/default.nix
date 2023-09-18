/*
* Oracle Cloud VM system configuration.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "yes";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg me@pweth.com"
  ];

  users.users.pweth = {
    description = "Peter";
    extraGroups = [
      "wheel"
    ];
    isNormalUser = true;
  };

  users.users.pweth.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg me@pweth.com"
  ];

  networking.hostName = "macaroni";

  time.timeZone = "Europe/London";

  system.stateVersion = "23.05";

}
