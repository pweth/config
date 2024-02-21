/*
* Cloudflare tunnel configuration.
*/

{ config, lib, hostName, host, ... }:
let
  credentials = "tunnel-${hostName}";
in
{
  config = lib.mkIf (builtins.hasAttr "tunnel" host) {
    # Credentials file
    age.secrets.cloudflare = {
      file = ./. + "/../secrets/${credentials}.age";
      owner = "cloudflared";
    };

    # Establish Cloudflared
    services.cloudflared = {
      enable = true;
      tunnels."${host.tunnel}" = {
        credentialsFile = config.age.secrets.cloudflare.path;
        default = "http_status:404";
      };
    };
  };
}
