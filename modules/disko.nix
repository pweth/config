# * Disk partition and filesystem configuration

{ config, lib, ... }:
let
  cfg = config.modules.disko;
in
{
  options.modules.disko = {
    enable = lib.mkEnableOption "disko";
    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/sda";
      description = "Persistent block device file.";
    };
    rootSize = lib.mkOption {
      type = lib.types.str;
      default = "2G";
      description = "Root filesystem size.";
    };
    swapSize = lib.mkOption {
      type = lib.types.str;
      default = "8G";
      description = "Swap file size.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Mount the root directory on tmpfs
    fileSystems = {
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = [
          "defaults"
          "size=${cfg.rootSize}"
          "mode=755"
        ];
      };
      "/persist".neededForBoot = true;
    };

    # Boot and LUKS-encrypted btrfs partitions
    disko.devices = {
      disk = {
        ssd = {
          type = "disk";
          device = cfg.device;
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                label = "boot";
                type = "EF00";
                size = "1G";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "defaults"
                  ];
                };
              };
              luks = {
                label = "encrypted";
                size = "100%";
                content = {
                  name = "cryptroot";
                  type = "luks";
                  extraOpenArgs = [
                    "--allow-discards"
                    "--perf-no_read_workqueue"
                    "--perf-no_write_workqueue"
                  ];
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-L" "data" "-f" ];
                    subvolumes = {
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "subvol=nix"
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/persist" = {
                        mountpoint = "/persist";
                        mountOptions = [
                          "subvol=persist"
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/swap" = {
                          mountpoint = "/swap";
                          swap.swapfile.size = cfg.swapSize;
                      };
                    };      
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
