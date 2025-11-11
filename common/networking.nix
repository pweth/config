# * Networking configuration.

{ config, lib, host, ... }:
let
  blockyHttpPort = 12346;
in
{
  # Networking
  networking = {
    hostName = host.name;
    nameservers = [ "127.0.0.1" ];
    networkmanager.dns = "none";
    useDHCP = lib.mkDefault true;
  };

  # Tailscale
  services.tailscale.enable = true;

  # DNS resolver
  services.blocky = {
    enable = true;
    settings = {
      blocking = {
        blockType = "nxdomain";
        clientGroupsBlock.default = [ "default" ];
        denylists.default = [
          "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.txt"
          "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/nsfw.txt"
          "https://pweth.com/noindex/blocklist.txt"
        ];
      };
      bootstrapDns = "tcp+udp:1.1.1.1";
      conditional = {
        mapping = {
          "ts.net" = "100.100.100.100";
        };
        rewrite = {
          "pweth.com" = "adelie-monitor.ts.net";
        };
      };
      log.level = "warn";
      ports = {
        dns = [ "127.0.0.1:53" ];
        http = [ "127.0.0.1:${builtins.toString blockyHttpPort}" ];
      };
      prometheus = {
        enable = true;
        path = "/dns";
      };
      upstreams.groups.default = [
        "https://dns.cloudflare.com/dns-query"
        "https://doh.opendns.com/dns-query"
        "https://dns.nextdns.io/dns-query"
        "https://dns.quad9.net/dns-query"
      ];
    };
  };

  # DNS metrics endpoint
  services.nginx.virtualHosts."${host.name}.pweth.com" = {
    locations."/dns" = {
      proxyPass = "http://localhost:${builtins.toString blockyHttpPort}";
    };
  };
}
