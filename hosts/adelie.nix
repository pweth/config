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
      enable = true; 
      device = "/dev/nvme0n1";
      rootSize = "8G";
    };
    gui.enable = true;
    home-manager.enable = true;
    impermanence.enable = true;
    virtualisation.enable = true;
  };

  # Boot settings
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "vmd"
        "xhci_pci"
      ];
    };
    kernelModules = [ "dm-snapshot" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Allow cross-architecture builds
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = false;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA-specific environment variables
  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/card1";
    GBM_BACKEND = "nvidia-drm";
    LIBGL_ALWAYS_SOFTWARE = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    "__GL_THREADED_OPTIMIZATIONS" = "0";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
  };

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
}
