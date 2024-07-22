/*
* Networking and DNS configuration.
*/

{ config, lib, pkgs, domain, host, hosts, ... }:

{ 
  networking = {
    # Hostname
    hostName = host.name;

    # Set DNS servers to localhost
    nameservers = [ "127.0.0.1" ];

    # NetworkManager
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  # Encrypted DNS
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      block_ipv6 = true;
      blocked_names.blocked_names_file = "/etc/blocklist";
      cloaking_rules = "/etc/cloaking";
      listen_addresses = [ "0.0.0.0:53" ];
      require_dnssec = true;
      require_nofilter = true;
      require_nolog = true;
    };
    upstreamDefaults = true;
  };

  # Cloaking configuration
  environment.etc.cloaking.text = builtins.concatStringsSep "\n" ([
    "docs.${domain} ${hosts.humboldt.address}"
    "git.${domain} ${hosts.humboldt.address}"
    "grafana.${domain} ${hosts.macaroni.address}"
    "jellyfin.${domain} ${hosts.humboldt.address}"
    "mask.${domain} ${hosts.macaroni.address}"
    "prometheus.${domain} ${hosts.macaroni.address}"
  ] ++ (builtins.concatMap (host: [
    "${host.name}.ipn.${domain} ${host.address}"
    "${host.name} ${host.address}"
  ]) (builtins.attrValues hosts)));

  # Systemd blocklist update service
  systemd = {
    services.update-blocklist = {
      script = ''
        touch /etc/blocklist
        ${pkgs.curl}/bin/curl https://big.oisd.nl/domainswild > /etc/blocklist
        ${pkgs.curl}/bin/curl https://nsfw.oisd.nl/domainswild >> /etc/blocklist
      '';
      serviceConfig = {
        Restart = "on-failure";
        Type = "oneshot";
        User = "root";
      };
    };
    timers.update-blocklist = {
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
        Unit = "update-blocklist.service";
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
