/*
* Raspberry Pi system configuration.
*/

{ config, pkgs, agenix, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # agenix
  environment.systemPackages = [
    agenix.packages.aarch64-linux.default
  ];

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
}
