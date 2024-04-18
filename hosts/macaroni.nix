/*
* Oracle VM system configuration.
*/

{ config, ... }:

{
  # Bootloader
  boot.loader.grub = {
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
  };

  # Tailscale exit node
  services.tailscale = {
    extraUpFlags = [ "--advertise-exit-node" ];
    useRoutingFeatures = "server";
  };
}
