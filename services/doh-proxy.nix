/*
* DoH and ODoH server proxy written in Rust for Firefox ECH.
* https://github.com/DNSCrypt/doh-server
*/

{ config, lib, domain, host, ... }:
let
  subdomain = "dns.${domain}";
  port = 16609;
in
{
  # HTTPS-over-DNS proxy
  services.doh-proxy-rust = {
    enable = true;
    flags = [
      "--hostname=${subdomain}"
      "--listen-address=127.0.0.1:${builtins.toString port}"
      "--path=/"
      "--server-address=127.0.0.1:53"
    ];
  };

  # Internal domain
  services.nginx.virtualHosts."${subdomain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    useACMEHost = "internal";
  };
}
