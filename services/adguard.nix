/*
* Network-wide ads and trackers blocking DNS server.
* https://github.com/AdguardTeam/AdGuardHome
*/

{ config, domain, host, hosts, ... }:
let
  subdomain = "dns.${domain}";
  port = 3000;
in
{
  # Service
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
    settings = {
      http.address = "127.0.0.1:${port}";
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        bootstrap_dns = [ "1.1.1.1" ];
        port = 53;
        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
          "https://doh.opendns.com/dns-query"
          "https://dns.nextdns.io"
        ];
      };
      filters = [
        { enabled = true; id = 1; name = "OISD Big"; url = "https://big.oisd.nl/"; }
        { enabled = true; id = 2; name = "OISD NSFW"; url = "https://nsfw.oisd.nl/"; }
      ];
      filtering.rewrites = [
        { domain = "*.pweth.com"; answer = hosts.humboldt.address; }
        { domain = "www.pweth.com"; answer = "pweth.com"; }
      ] ++ (builtins.map (
        host: { domain = "${host.name}.ipn.pweth.com"; answer = host.address; }
      ) (builtins.attrValues hosts));
      statistics = {
        enabled = true;
        interval = "2160h";
      };
      theme = "dark";
    };
  };

  # Internal domain
  services.nginx.virtualHosts."${subdomain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/pweth.crt;
    sslCertificateKey = config.age.secrets.certificate.path;
  };
}
