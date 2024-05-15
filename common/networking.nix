/*
* Networking and DNS configuration.
*/

{ config, lib, pkgs, host, hosts, ... }:

{ 
  networking = {
    # Hostname
    hostName = host.name;

    # Set DNS servers to localhost
    nameservers = [ "127.0.0.1" ];
    networkmanager.dns = "none";
  };

  # Encrypted DNS
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      block_ipv6 = true;
      blocked_names.blocked_names_file = "/etc/blocklist";
      cloaking_rules = "/etc/cloaking";
      listen_addresses = [ "127.0.0.1:53" ];
      require_dnssec = true;
      require_nofilter = true;
      require_nolog = true;
    };
    upstreamDefaults = true;
  };

  # Configuration files
  environment.etc = {
    blocklist.source = lib.mkIf (builtins.hasAttr "persistent" host) "${host.persistent}/etc/blocklist";
    cloaking.text = builtins.concatStringsSep "\n" ([
      "[a-z]*.pweth.com humboldt.home.arpa"
    ] ++ (builtins.map (
      host: "${host.name}.home.arpa ${host.address}"
    ) (builtins.attrValues hosts)));
  };

  # Systemd blocklist update service
  systemd = {
    services.update-blocklist = {
      script = ''
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
