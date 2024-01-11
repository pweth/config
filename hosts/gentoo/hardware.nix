/*
* Hardware scan for Dell OptiPlex 3050 Micro.
*/

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/333c0623-2475-4d31-ae62-87cfcec100c9";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/EF6D-E20B";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/6e18760e-2df8-4df6-9088-c1248c131e7f";
    }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
