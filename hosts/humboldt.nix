/*
* Home server system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/forgejo.nix
    ../services/jellyfin.nix
    ../services/masked-email.nix
    ../services/paperless.nix
    ../services/restic.nix
  ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # VSCode server
  services.vscode-server.enable = true;
}
