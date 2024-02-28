/*
* /etc/hosts configuration.
*/

{ config, host, hosts, ... }:

{
  networking.hosts = builtins.listToAttrs (builtins.attrValues (builtins.mapAttrs (
    # host.ipn.home.arpa DNS entries
    name: value: {
      name = value.address;
      value = [ "${name}.ipn.home.arpa" ];
    }
  ) hosts)) // {
    # Service DNS entries
    "${hosts.humboldt.address}" = [
      "assistant.home.arpa"
      "grafana.home.arpa"
      "paperless.home.arpa"
      "prometheus.home.arpa"
    ];
  };
}
