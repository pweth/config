/*
* Home server system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/cowyo.nix
    ../services/grafana.nix
    ../services/home-assistant.nix
    ../services/paperless.nix
    ../services/prometheus.nix
    ../services/restic.nix
    ../services/rollback.nix
  ];
  
  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # ACME
  age.secrets.dns-01.file = ../secrets/dns-01.age;
  security.acme = {
    acceptTerms = true;
    defaults = {
      dnsPropagationCheck = false;
      dnsProvider = "cloudflare";
      email = "9iz5svuo@duck.com";
      environmentFile = config.age.secrets.dns-01.path;
    };
  };
}
