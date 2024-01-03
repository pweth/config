/*
* Oracle Cloud VM system configuration.
*/

{ config, pkgs, home-manager, ... }:

{
  imports = [
    ./hardware.nix
    ../../common/ssh.nix
    ../../services
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Home manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pweth = import ../../home;
  };

  # Networking
  networking = {
    hostName = "macaroni";
    firewall.allowedTCPPorts = [ 443 ];
    nameservers = [ "127.0.0.1" "::1" ];
  };

  # Certificates
  age.secrets.cloudflare.file = ../../secrets/cloudflare.age;
  security.acme = {
    acceptTerms = true;
    defaults.email = "9iz5svuo@duck.com";
  };

  # nginx reverse proxy
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  # System services
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
  services.vscode-server.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
}
