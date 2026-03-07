{ config, ... }:

{
  imports = [
    ./grafana.nix
    ./immich.nix
    ./jellyfin.nix
    ./prometheus.nix
    ./usenet.nix
  ];

  # Cloudflare API token
  age.secrets.cloudflare = {
    file = ../agenix/cloudflare.age;
    group = "acme";
    owner = "acme";
  };

  # Let's Encrypt DNS-01 challenge
  security.acme = {
    acceptTerms = true;
    certs.intranet = {
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      domain = "intranet.london";
      environmentFile = config.age.secrets.cloudflare.path;
      extraDomainNames = [ "*.intranet.london" ];
      group = "nginx";
    };
    defaults.email = "22416843+pweth@users.noreply.github.com";
  };

  # Reverse proxy
  services.nginx = {
    enable = true;
    clientMaxBodySize = "0";
    recommendedBrotliSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedUwsgiSettings = true;
  };
}
