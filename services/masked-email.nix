# * Custom Python web service for generating FastMail email aliases.

{
  config,
  pkgs,
  domain,
  ...
}:
let
  subdomain = "mask.${domain}";
  port = 40368;
  python = pkgs.python3.withPackages (ps: with ps; [ requests ]);
in
{
  # Masked email Python script
  age.secrets.masked-email.file = ../secrets/masked-email.age;

  # Systemd service
  systemd.services.masked-email = {
    serviceConfig = {
      ExecStart = "${python}/bin/python ${config.age.secrets.masked-email.path}";
      RestartSec = 120;
    };

    environment.SERVICE_RUN_MODE = "1";
    startLimitBurst = 10;
    startLimitIntervalSec = 5;
    after = [ "run-agenix.d.mount" ];
    wants = [ "run-agenix.d.mount" ];
    wantedBy = [ "multi-user.target" ];
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
