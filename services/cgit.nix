/*
* A hyperfast web frontend for git repositories written in C.
* https://git.zx2c4.com/cgit/about/
*/

{ config, lib, host, ... }:
let
  domain = "git.pweth.com";
  port = 44615;
  storage = "/var/lib/git";
in
{
  # Service
  services.cgit.default = {
    enable = true;
    nginx.virtualHost = domain;
    scanPath = storage;
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    acmeRoot = null;
    enableACME = true;
    forceSSL = true;
  };

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ storage ];
  };
}
