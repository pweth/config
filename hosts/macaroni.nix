# * Media server system configuration.

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
  ];

  # Custom modules
  modules = {
    disko = {
      enable = true;
      device = "/dev/sda";
    };
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
    };
    kernelModules = [ "kvm-intel" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Hardware adjustments
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Networking
  networking.nat.externalInterface = "enp2s0";
}
