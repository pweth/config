/*
* ACME configuration for internal TLS certificates.
*/

{ config, ... }:

{
  # Mount API key for DNS-01 challenge
  age.secrets.dns-01.file = ../secrets/dns-01.age;

  # ACME settings
  security.acme = {
    acceptTerms = true;
    defaults = {
      dnsPropagationCheck = false;
      dnsProvider = "cloudflare";
      email = "9iz5svuo@duck.com";
      environmentFile = config.age.secrets.dns-01.path;
    };
  };
}
