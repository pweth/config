/*
* HTTP and reverse proxy server.
* https://nginx.org/
*/

{ config, ... }:

{
  # Reverse proxy
  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedZstdSettings = true;

    # Reject requests by default
    virtualHosts.default = {
      default = true;
      locations."/".return = "444";
      rejectSSL = true;
    };
  };
}
