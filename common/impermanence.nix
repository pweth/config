/*
* Common configuration across all hosts that use impermanence.
*/

{ config, lib, host, user, ... }:

{
  config = lib.mkIf (builtins.hasAttr "persistent" host) {
    # Add persistent key path to agenix
    age.identityPaths = [ "${host.persistent}/etc/ssh/ssh_host_ed25519_key" ];

    # /etc files
    environment.etc = {
      blocklist.source = "${host.persistent}/etc/blocklist";
      machine-id.source = "${host.persistent}/etc/machine-id";
      "ssh/ssh_host_ed25519_key".source = "${host.persistent}/etc/ssh/ssh_host_ed25519_key";
    };
    
    # Use hidden bind mounts to persist required directories
    environment.persistence."${host.persistent}" = {
      hideMounts = true;
      directories = lib.mkMerge [
        [
          "/etc/nixos/config"
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
            "Games"
            ".config/Code"
            ".config/discord"
            ".config/input-remapper"
            ".config/libreoffice"
            ".config/spotify"
            ".config/Standard Notes"
            ".local/share/Anki2"
            ".local/share/Emote"
            ".local/share/keyrings"
            ".local/share/lutris"
            ".mozilla/firefox/default"
          ])
        ];
        files = [ ".bash_history" ];
      };
    };
  };
}
