{ host, inputs, ... }:

{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
    ./services
    ./disko.nix
    ./hardware.nix
    ./impermanence.nix
    ./pkgs.nix
    ./security.nix
    ./user.nix
  ];

  # Allow cross-architecture builds
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Add ~/.local/bin to path
  environment.localBinInPath = true;

  # Allow unpatched binaries (e.g. VS Code Server) to run
  programs.nix-ld.enable = true;

  # Nix settings
  nix = {
    enable = true;
    settings.auto-optimise-store = true;
  };

  # Networking
  networking.networkmanager.enable = true;

  # Node exporter
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
  };

  # Tailscale
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--accept-dns"
      "--advertise-exit-node"
    ];
    useRoutingFeatures = "both";
  };

  # Original release version
  system.stateVersion = "24.11";
}
