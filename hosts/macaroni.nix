/*
* Oracle VM system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/grafana.nix
    ../services/masked-email.nix
    ../services/prometheus.nix
  ];

  # Bootloader
  boot.loader.grub = {
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
  };
}
