{ config, ... }:

{
  # Services
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    localModels = [
      "gemma2:2b"
      "llama3.2:3b"
      "qwen2.5-coder:3b"
    ];
    syncModels = true;
  };
  services.open-webui.enable = true;

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/private/ollama"
    "/var/lib/private/open-webui"
  ];

  # Virtual host
  services.nginx.virtualHosts."chat.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.open-webui.port}";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_buffering off;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
        send_timeout 600s;
      '';
    };
  };
}
