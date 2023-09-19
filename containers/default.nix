{ config, pkgs, ... }:

{
  imports = [
    ./cowyo.nix
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  age.secrets.cloudflare-api.file = ../secrets/cloudflare-api.age;
  security.acme = {
    acceptTerms = true;
    defaults.email = "9iz5svuo@duck.com";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
}
