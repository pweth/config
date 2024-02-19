/*
* Oracle Cloud Micro VM system configuration.
*/

{ config, ... }:

{
  # Bootloader
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };
  boot.cleanTmpDir = true;
  zramSwap.enable = true;

  # ClamAV and fail2ban
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
  services.fail2ban.enable = true;
}
