# * Raspberry Pi system configuration.

{
  config,
  lib,
  modulesPath,
  nixos-hardware,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.raspberry-pi-3
    ../services/cage.nix
  ];

  # Boot settings
  boot = {
    initrd.availableKernelModules = [ "usbhid" ];
    loader = {
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
    };
  };

  # Filesystem mounts
  fileSystems."/" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
  };

  # Power management
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
