/*
* Personal laptop system configuration.
*/

{ config, lib, modulesPath, nixos-hardware, user, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.dell-xps-13-9360
    ../gui
    ../home
  ];

  # Boot settings
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
      luks.devices.luks.device = "/dev/disk/by-label/encrypted";
    };
    kernelModules = [ "kvm-intel" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Filesystem mounts
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/nix" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };
    "/persist" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "subvol=persist" "compress=zstd" "noatime" ];
    };
  };

  # Swap space
  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  # Hardware adjustments
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Logitech peripherals
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # NetworkManager
  networking.networkmanager = {
    enable = true;
    dns = "none";
  };

  # Sound and Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # Disable SSH and fail2ban
  services.openssh.enable = lib.mkForce false;
  services.fail2ban.enable = lib.mkForce false;

  # Tailscale client
  services.tailscale.useRoutingFeatures = "client";
}
