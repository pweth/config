/*
* DoH and ODoH server proxy written in Rust for Firefox ECH.
* https://github.com/DNSCrypt/doh-server
*/

{ config, lib, host, ... }:
let
  domain = "dns.pweth.com";
  port = 16609;
in
{
  # HTTPS-over-DNS proxy
  services.doh-proxy-rust = {
    enable = true;
    flags = [
      "--hostname=${domain}"
      "--listen-address=127.0.0.1:${builtins.toString port}"
      "--path=/"
      "--server-address=127.0.0.1:53"
    ];
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    useACMEHost = "internal";
  };
}
