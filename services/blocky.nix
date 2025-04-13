/*
  * Fast and lightweight DNS proxy as ad-blocker for local network.
  * https://github.com/0xERR0R/blocky
*/

{ config, host, ... }:
let
  domain = "dns.pweth.com";
  port = 4050;
in
{
  # Service
  services.blocky = {
    enable = true;
    settings = {
      blocking = {
        blockType = "nxDomain";
        clientGroupsBlock.default = [ "default" ];
        denylists.default = builtins.map (
          list: "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/${list}.txt"
        ) [
          "gambling"
          "nsfw"
          "pro.plus"
          "tif"
        ];
      };
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
      conditional = {
        mapping = {
          "ts.net" = "100.100.100.100";
        };
        rewrite = {
          "ipn.pw" = "adelie-monitor.ts.net";
        };
      };
      customDNS.mapping = {
        "pweth.com" = host.address;
      };
      fqdnOnly.enable = true;
      log.level = "warn";
      ports.http = [ port ];
      prometheus.enable = true;
      upstreams.groups.default = [
        "https://dns.cloudflare.com/dns-query"
        "https://doh.opendns.com/dns-query"
        "https://dns.nextdns.io"
      ];
    };
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/certs/service.crt;
    sslCertificateKey = config.age.secrets.service.path;
  };
}
