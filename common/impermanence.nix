/*
* Common configuration across all hosts that use impermanence.
*/

{ config, lib, impermanence, user, ... }:

{
  imports = [
    impermanence.nixosModules.impermanence
  ];

  # Add persistent key path to agenix
  age.identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

  # /etc files
  environment.etc = {
    machine-id.source = "/persist/etc/machine-id";
    "ssh/ssh_host_ed25519_key".source = "/persist/etc/ssh/ssh_host_ed25519_key";
  };

  # Use hidden bind mounts to persist required directories
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = lib.mkMerge [
      [
        "/etc/nixos"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/log/journal"
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
        [
          ".config/nvim"
          ".local/share/nvim"
          ".passage"
          ".ssh"
        ]

        # Only persist on GUI systems
        (lib.mkIf config.services.xserver.enable [
          "Documents"
          "Downloads"
          "Pictures"
          ".config/Code"
          ".config/libreoffice"
          ".config/pcmanfm/default"
          ".config/spotify"
          ".local/share/Anki2"
          ".local/share/Emote"
          ".local/share/keyrings"
          ".mozilla/firefox/default"
        ])
      ];
      files = [
        ".bash_history"
      ];
    };
  };
}
