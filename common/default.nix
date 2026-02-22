{ config, host, lib, ... }:

{
  imports = [
    ./env.nix
    ./home-manager.nix
    ./pkgs.nix
  ];

  # Experimental features
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
    "pipe-operators"
  ];

  # Hostname
  networking.hostName = host.name;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Platform
  nixpkgs.hostPlatform = lib.mkDefault host.architecture;

  # Tailscale
  services.tailscale.enable = true;

  # Timezone
  time.timeZone = "Europe/London";
}
