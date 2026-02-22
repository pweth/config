{ config, inputs, lib, modulesPath, ... }:

{
  imports = with inputs; [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  # Boot settings
  boot = {
    initrd.availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "vmd"
        "xhci_pci"
    ];
    kernelModules = [
      "dm-snapshot"
      "nvidia_drm"
      "nvidia_modeset"
      "nvidia_uvm"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # CPU firmware
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Graphics card
  hardware.nvidia = {
    modesetting.enable = true; 
    nvidiaSettings = false; 
    open = false; 
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
  };

  # NVIDIA-specific environment variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NVIDIA_DRIVER_CAPABILITIES = "compute,utility,video";
    NVIDIA_VISIBLE_DEVICES = "all";
  };
}
