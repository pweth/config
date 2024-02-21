/*
* Oracle Cloud VM system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/grafana.nix
    ../services/prometheus.nix
    ../services/uptime-kuma.nix
  ];

  # Bootloader
  boot.loader.grub = {
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
  };
}
