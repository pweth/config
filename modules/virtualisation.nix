# * Common configuration across all hosts that use virtualisation.

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.virtualisation;
in
{
  options.modules.virtualisation = {
    enable = lib.mkEnableOption "virtualisation";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };
    };

    users.users.pweth.extraGroups = [
      "kvm"
      "libvirtd"
    ];
  };
}
