/*
* Hardware scan for Dell XPS 13 9360.
*/

{ config, lib, pkgs, modulesPath, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.dell-xps-13-9360
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7865ea69-0b78-4b22-8550-db5db105e649";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" ];
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/cf1ad024-e35d-4ce1-ae16-677276b86fee";

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/7865ea69-0b78-4b22-8550-db5db105e649";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/7865ea69-0b78-4b22-8550-db5db105e649";
    fsType = "btrfs";
    options = [ "subvol=persist" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6C11-4925";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/00c0a699-ae8d-47ec-9257-eb10b421cb35"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
