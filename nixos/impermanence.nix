{ config, inputs, lib, ... }:

{
  imports = with inputs; [
    impermanence.nixosModules.impermanence
  ];

  # Add persistent key path to agenix
  age.identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

  # /etc files
  environment.etc = {
    machine-id.source = "/persist/etc/machine-id";
    "ssh/ssh_host_ed25519_key".source = "/persist/etc/ssh/ssh_host_ed25519_key";
  };

  # Use hidden bind mounts to persist directories and files
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = lib.mkMerge [
      [
        "/etc/nixos"
        "/var/lib/nixos"
        "/var/log/journal"
      ]
      (lib.mkIf config.services.tailscale.enable [
        "/var/lib/tailscale"
      ])
    ];
    users.pweth.files = [ ".bash_history" ];
  };
}
