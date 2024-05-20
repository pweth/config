/*
* Oracle VM system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/masked-email.nix
    ../services/prometheus.nix
  ];

  # Bootloader
  boot.loader.grub = {
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
  };

  # Allow DNS requests from phone
  services.dnscrypt-proxy2.settings.listen_addresses = [ "0.0.0.0:53" ];
}
