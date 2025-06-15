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
    disko.enable = true;
    gui.enable = false;
    home-manager.enable = true;
    impermanence.enable = true;
  };

  # Boot settings
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "r8169"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      network = {
        enable = true;
        udhcpc.enable = true;
        ssh = {
          enable = true;
          hostKeys = [ "/boot/ecdsa.key" ];
          authorizedKeys = config.users.users.pweth.openssh.authorizedKeys.keys;
        };
        postCommands = ''
          echo 'cryptsetup-askpass' >> /root/.profile
        '';
      };
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
  networking.nat.externalInterface = "enp1s0";
}
