{ inputs, ... }:

{
  imports = with inputs; [
    disko.nixosModules.disko
  ];

  # Mount the root directory on tmpfs
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
    "/persist".neededForBoot = true;
  };

  disko.devices = {
    # Boot and LUKS-encrypted btrfs partitions
    disk = {
      ssd = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-PM9F1_Samsung_1024GB_______S7NTNE0X737948";
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
                  extraArgs = [
                    "-L"
                    "data"
                    "-f"
                  ];
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
                      swap.swapfile.size = "8G";
                    };
                  };
                };
              };
            };
          };
        };
      };

      # LUKS-encrypted btrfs media drive
      media = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CT4000P310SSD8_25395336D02A";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              label = "encrypted-media";
              size = "100%";
              content = {
                name = "cryptmedia";
                type = "luks";
                keyFile = "/persist/luks/media.key";
                extraOpenArgs = [ "--allow-discards" ];
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "media"
                    "-f"
                  ];
                  subvolumes = {
                    "/media" = {
                      mountpoint = "/media";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
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
