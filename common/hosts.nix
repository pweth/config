/*
* /etc/hosts configuration.
*/

{ config, host, hosts, ... }:

{
  # Service DNS entries
  networking.hosts."${hosts.humboldt.address}" = [
    "assistant.home.arpa"
    "grafana.home.arpa"
    "paperless.home.arpa"
    "prometheus.home.arpa"
  ];
}
