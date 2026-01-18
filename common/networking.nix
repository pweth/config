# * Networking configuration.

{ config, host, ... }:

{
  # Networking
  networking.hostName = host.name;

  # Tailscale
  services.tailscale.enable = true;

  # MagicDNS masquerade
  services.blocky = {
    enable = true;
    settings = {
      conditional = {
        mapping = {
          "ts.net" = "100.100.100.100";
        };
        rewrite = {
          "pweth.com" = "adelie-monitor.ts.net";
        };
      };
      upstreams.groups.default = [
        "https://dns.cloudflare.com/dns-query"
      ];
    };
  };
}
