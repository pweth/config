/*
* Scan, index and archive all your physical documents.
* https://github.com/paperless-ngx/paperless-ngx
*/

{ config, lib, host, ... }:
let
  domain = "docs.pweth.com";
  port = 36095;
in
{
  # Admin password
  age.secrets.paperless = {
    file = ../secrets/paperless.age;
    owner = "paperless";
  };

  # Service configuration
  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    extraConfig = {
      PAPERLESS_APP_TITLE = "Paperless";
      PAPERLESS_DATE_ORDER = "DMY";
    };
    passwordFile = config.age.secrets.paperless.path;
    port = port;
  };

  # Cloudflare tunnel
  services.cloudflared.tunnels."${host.tunnel}".ingress = {
    "${domain}" = "http://localhost:${builtins.toString port}";
  };

  # Persist service configuration
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/paperless" ];
  };
}