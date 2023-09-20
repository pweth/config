/*
* The open and composable observability and data visualization platform.
* https://github.com/grafana/grafana
*/

{ config, pkgs, ... }:

{
  age.secrets.grafana-password = {
    file = ../secrets/grafana-password.age;
    owner = "grafana";
    group = "grafana";
  };

  services.grafana = {
    enable = true;
    settings.security.admin_password = "$__file{${config.age.secrets.grafana-password.path}}";
  };
}
