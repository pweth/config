/*
* Runs a DNS-over-HTTPS proxy for the local DHCP DNS server.
* This allows captive portals to be opened in Firefox without having to disable DNSCrypt.
*/

{ config, lib, pkgs, ... }:
let
  port = 11111;
in
{
  # Mount localhost TLS key
  age.secrets.localhost-key.file = ../secrets/localhost-key.age;

  # Proxy configuration
  systemd.services.local-dns = {
    path = with pkgs; [
      coreutils
      doh-proxy-rust
      gawk
      gnugrep
      networkmanager
    ];
    script = ''
      SSID=$(nmcli connection show | grep "wifi" | head -n 1 | awk '{print $1}')
      DNS_SERVER=$(nmcli connection show $SSID | grep "IP4.DNS" -m 1 | awk '{print $2}')
      doh-proxy --hostname=localhost \
        --listen-address=127.0.0.1:${builtins.toString port} \
        --path=/ \
        --server-address=$DNS_SERVER:53 \
        --tls-cert-path=${builtins.toString ../keys/certificates/localhost.crt} \
        --tls-cert-key-path=${config.age.secrets.localhost-key.path}
    '';
    serviceConfig.User = "root";
  };
}
