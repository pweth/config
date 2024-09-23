/*
* Raspberry Pi system configuration.
*/

{ config, lib, modulesPath, nixos-hardware, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.raspberry-pi-3
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
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  # Power management
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
