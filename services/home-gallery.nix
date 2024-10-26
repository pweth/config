/*
* Self-hosted open-source web gallery.
* https://github.com/xemle/home-gallery
*/

{ config, domain, ... }:
let
  subdomain = "photos.${domain}";
  port = 27839;
in
{
  # Docker container
  virtualisation.oci-containers.containers.home-gallery = {
    autoStart = true;
    cmd = [ "run" "server" ];
    image = "xemle/home-gallery";
    ports = [ "${builtins.toString port}:3000" ];
    volumes = [
      "/persist/data/home-gallery:/data"
      "/persist/media/Photos:/data/Pictures"      
    ];
  };

  # Internal domain
  services.nginx.virtualHosts."${subdomain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/pweth.crt;
    sslCertificateKey = config.age.secrets.certificate.path;
  };
}
