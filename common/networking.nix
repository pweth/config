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
      ipv6_servers = false;
      listen_addresses = [ "127.0.0.1:53" ];
      require_dnssec = true;
      server_names = [
        "cloudflare"
        "mullvad-doh"
        "nextdns"
      ];
    };
    upstreamDefaults = true;
  };

  # Configuration files
  environment.etc = {
    blocklist.source = lib.mkIf (builtins.hasAttr "persistent" host) "${host.persistent}/etc/blocklist";
    cloaking.text = ''
      *.pweth.com ${hosts.humboldt.address}
    '';
  };

  # Systemd service for daily blocklist update
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
        OnCalendar = "daily";
        Persistent = true;
        Unit = "update-blocklist.service";
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
