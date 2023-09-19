{ config, pkgs, ... }:

{
  imports = [
    ./cowyo.nix
    ./radicale.nix
  ];

  networking.firewall.allowedTCPPorts = [
    443
  ];

  # Certificates
  age.secrets.cloudflare-api.file = ../secrets/cloudflare-api.age;
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
}
