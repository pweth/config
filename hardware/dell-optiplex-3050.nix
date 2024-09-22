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

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=25%" "mode=755" ];
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/edeac7b4-70d4-457c-a29d-2f0d2220c070";

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/fb3851f9-8107-49a2-9643-bced576a9497";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/fb3851f9-8107-49a2-9643-bced576a9497";
    fsType = "btrfs";
    options = [ "subvol=persist" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/fb3851f9-8107-49a2-9643-bced576a9497";
    fsType = "btrfs";
    options = [ "subvol=data" "compress=zstd" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/00944f6b-c604-45a3-9551-994c6de989b9";
    fsType = "ext2";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/f099c486-2d8b-49c3-9814-d1d9098ca62e"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
