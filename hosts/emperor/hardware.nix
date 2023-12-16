/*
* Hardware scan for Dell Inc. XPS 13 9360.
*/

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/71313c63-6bbd-4f7a-aa92-c951dcc1c67e";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/EE25-8184";
      fsType = "vfat";
    };
  };

  boot.initrd.luks.devices."luks-be2d24fa-a7dd-4f51-ba36-5d4cccd9c16e" = {
    device = "/dev/disk/by-uuid/be2d24fa-a7dd-4f51-ba36-5d4cccd9c16e";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
