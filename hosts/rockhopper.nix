/*
* Raspberry Pi system configuration.
*/

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
  ];

  # Custom modules
  modules.home-manager.enable = true;

  # Boot settings
  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ "usbhid" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  # Filesystem mounts
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  # Swap space
  swapDevices = [ ];

  # Hardware adjustments
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
