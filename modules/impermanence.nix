# * Common configuration across all hosts that use impermanence.

{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.impermanence;
in
{
  options.modules.impermanence = {
    enable = lib.mkEnableOption "impermanence";
    path = lib.mkOption {
      type = lib.types.str;
      default = "/persist";
      description = "Location for persistent state.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add persistent key path to agenix
    age.identityPaths = [ "${cfg.path}/etc/ssh/ssh_host_ed25519_key" ];

    # /etc files
    environment.etc = {
      machine-id.source = "${cfg.path}/etc/machine-id";
      "ssh/ssh_host_ed25519_key".source = "${cfg.path}/etc/ssh/ssh_host_ed25519_key";
    };

    # Use hidden bind mounts to persist required directories
    environment.persistence."${cfg.path}" = {
      hideMounts = true;
      directories = lib.mkMerge [
        [
          "/etc/nixos"
          "/var/lib/nixos"
          "/var/log/journal"
        ]
        (lib.mkIf config.hardware.bluetooth.enable [
          "/var/lib/bluetooth"
        ])
        (lib.mkIf config.networking.networkmanager.enable [
          "/etc/NetworkManager/system-connections"
        ])
        (lib.mkIf config.services.tailscale.enable [
          "/var/lib/tailscale"
        ])
      ];
      users.pweth = {
        directories = lib.mkMerge [
          [
            ".config/nvim"
            ".local/share/nvim"
            ".passage"
            ".ssh"
          ]

          # Only persist on GUI systems
          (lib.mkIf config.modules.gui.enable [
            "Documents"
            "Downloads"
            "Pictures"
            ".config/Code"
            ".config/libreoffice"
            ".config/spotify"
            ".config/VirtualBox"
            ".local/share/Anki2"
            ".mozilla/firefox/default"
          ])
        ];
        files = [ ".bash_history" ];
      };
    };
  };
}
