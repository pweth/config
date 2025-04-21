/*
  * Fast and lightweight DNS proxy as ad-blocker for local network.
  * https://github.com/0xERR0R/blocky
*/

{ config, lib, host, ... }:

{
  config = lib.mkIf (host.services.blocky or null != null) {
    modules.services.blocky = {
      subdomain = host.services.blocky;
      address = "192.168.1.3";
      tag = "dns";

      config.services.blocky = {
        enable = true;
        settings = {
          blocking = {
            blockType = "nxDomain";
            clientGroupsBlock.default = [ "default" ];
            denylists.default = [
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.txt"
              "https://pweth.com/noindex/blocklist.txt"
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
              "pweth.com" = "adelie-monitor.ts.net";
            };
          };
          fqdnOnly.enable = true;
          log.level = "warn";
          ports.http = [ config.modules.services.blocky.port ];
          prometheus.enable = true;
          upstreams.groups.default = [
            "https://dns.cloudflare.com/dns-query"
            "https://doh.opendns.com/dns-query"
            "https://dns.nextdns.io"
          ];
        };
      };
    };
  };
}
