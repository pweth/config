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

  # Boot and LUKS-encrypted btrfs partitions
  disko.devices = {
    disk = {
      ssd = {
        type = "disk";
        device = "/dev/nvme0n1";
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
                        swap.swapfile.size = "8G";
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
