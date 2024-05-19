/*
* ACME configuration for internal TLS certificates.
*/

{ config, lib, host, ... }:

{
  # Mount API key for DNS-01 challenge
  age.secrets.dns-01.file = ../secrets/dns-01.age;

  # ACME settings
  security.acme = {
    acceptTerms = true;
    certs.internal = {
      dnsPropagationCheck = true;
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      domain = "${host.name}.ipn.pw";
      email = "9iz5svuo@duck.com";
      environmentFile = config.age.secrets.dns-01.path;
      extraDomainNames = [ "*.pweth.com" ];
      validMinDays = 90;
    };
  };

  # Add nginx to the ACME group
  users.users.nginx.extraGroups = [ "acme" ];

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/acme" ];
  };
}
