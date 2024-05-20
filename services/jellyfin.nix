/*
* The free software media system.
* https://github.com/jellyfin/jellyfin
*/

{ config, lib, domain, host, hosts, ... }:
let
  subdomain = "jellyfin.${domain}";
  port = 8096;
in
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
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

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/jellyfin" ];
  };
}
