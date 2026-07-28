{ ... }:

{
  # Service
  services.blocky = {
    enable = true;
    settings = {
      bootstrapDns = "tcp+udp:1.1.1.1";
      connectIPVersion = "v4";
      log.level = "warn";
      ports = {
        dns = [ "0.0.0.0:53" ];
        http = [ "127.0.0.1:9823" ];
      };
      prometheus = {
        enable = true;
        path = "/dns";
      };
      upstreams.groups.default = [
        "https://uloopau6v1.cloudflare-gateway.com/dns-query"
      ];
    };
  };

  # Virtual host
  services.nginx.virtualHosts."blocky.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/dns".proxyPass = "http://localhost:9823";
  };
}
