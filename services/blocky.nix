/*
  * Fast and lightweight DNS proxy as ad-blocker for local network.
  * https://github.com/0xERR0R/blocky
*/

{ config, lib, host, ... }:

{
  config = lib.mkIf (builtins.elem "blocky" host.services) {
    modules.services.blocky = {
      subdomain = "dns-${host.name}";
      tag = "dns";

      config.services.blocky = {
        enable = true;
        settings = {
          blocking = {
            blockType = "nxDomain";
            clientGroupsBlock.default = [ "default" ];
            denylists.default = [
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.txt"
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/nsfw.txt"
              "https://pweth.com/noindex/blocklist.txt"
            ];
          };
          bootstrapDns = {
            upstream = "https://dns.cloudflare.com/dns-query";
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
          connectIPVersion = "v4";
          fqdnOnly.enable = true;
          log.level = "warn";
          ports.http = [ 
            "127.0.0.1:${builtins.toString config.modules.services.blocky.port}"
          ];
          prometheus.enable = true;
          upstreams.groups.default = [
            "https://dns.cloudflare.com/dns-query"
            "https://doh.opendns.com/dns-query"
            "https://dns.nextdns.io/dns-query"
            "https://dns.quad9.net/dns-query"
          ];
        };
      };
    };
  };
}
