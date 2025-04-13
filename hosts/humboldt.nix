# * Home server system configuration.

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
    nixos-hardware.nixosModules.dell-optiplex-3050
    ../services/anki-sync.nix
    ../services/blocky.nix
    ../services/forgejo.nix
    ../services/grafana.nix
    ../services/immich.nix
    ../services/jellyfin.nix
    ../services/masked-email.nix
    ../services/prometheus.nix
  ];

  # Custom modules
  modules = {
    gui.enable = false;
    home-manager.enable = true;
    impermanence.enable = true;
  };

  # Boot settings
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
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
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=2G"
        "mode=755"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/persist" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=persist"
        "compress=zstd"
        "noatime"
      ];
    };
  };

  # Swap space
  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  # Hardware adjustments
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Mount services certificate key
  age.secrets.service = {
    file = ../secrets/service.age;
    owner = "nginx";
  };
}
