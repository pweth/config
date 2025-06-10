# * Desktop system configuration.

{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Custom modules
  modules = {
    disko = {
      enable = false; 
      device = "/dev/nvme0n1";
      rootSize = "8G";
    };
    gui.enable = true;
    home-manager.enable = true;
    impermanence.enable = true;
  };

  # Boot settings
  boot = {
    initrd = {
      availableKernelModules = [
        "vmd"
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      luks.devices.luks = {
        device = "/dev/disk/by-label/encrypted";
        preLVM = true;
      };
    };
    kernelModules = [ "dm-snapshot" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Allow cross-architecture builds
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Filesystem mounts
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=8G"
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

  # Logitech peripherals
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # Graphics card
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  # OpenGL
  hardware.graphics.enable = true;

  # Networking
  networking = {
    nat.externalInterface = "wlp0s20f3";
    networkmanager.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Disable SSH and fail2ban
  services.openssh.enable = lib.mkForce false;
  services.fail2ban.enable = lib.mkForce false;

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "pweth" ];
}
