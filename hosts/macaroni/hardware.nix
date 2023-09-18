/*
* Hardware scan for Oracle Cloud VM.Standard.A1.Flex.
*/

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "virtio_scsi" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/3eb2ff39-b8d9-4f21-b43e-fd4d0476a1b6";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/91D7-DBCD";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
