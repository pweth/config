/*
* Common configuration across all hosts that use impermanence.
*/

{ config, lib, host, user, ... }:

{
  config = lib.mkIf host.impermanent {
    # Add persistent key path to agenix
    age.identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

    # /etc files
    environment.etc = {
      blocklist.source = "/persist/etc/blocklist";
      machine-id.source = "/persist/etc/machine-id";
      "ssh/ssh_host_ed25519_key".source = "/persist/etc/ssh/ssh_host_ed25519_key";
    };

    # Use hidden bind mounts to persist required directories
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = lib.mkMerge [
        [
          "/etc/nixos"
          "/var/lib/systemd/coredump"
        ]
        (lib.mkIf config.networking.networkmanager.enable [
          "/etc/NetworkManager/system-connections"
        ])
        (lib.mkIf config.hardware.bluetooth.enable [
          "/var/lib/bluetooth"
        ])
      ];
      users."${user}" = {
        directories = lib.mkMerge [
          [ ".passage" ".ssh" ]

          # Only persist on GUI systems
          (lib.mkIf config.services.xserver.enable [
            "Documents"
            "Downloads"
            "Pictures"
            ".config/Code"
            ".config/discord"
            ".config/libreoffice"
            ".config/spotify"
            ".config/Standard Notes"
            ".local/share/Anki2"
            ".local/share/Emote"
            ".local/share/keyrings"
            ".mozilla/firefox/default"
          ])
        ];
        files = [ ".bash_history" ];
      };
    };
  };
}
