/*
  * Waybar configuration.
  * https://github.com/Alexays/Waybar
*/

{ config, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = [
      {
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "custom/vpn"
          "bluetooth"
          "pulseaudio"
          "idle_inhibitor"
        ];

        # Module configuration
        "bluetooth" = {
          format = " ";
          on-click = "blueman-manager";
          tooltip-format = builtins.concatStringsSep "\n" [
            "Status:  {status}"
            "Devices: {num_connections}"
          ];
        };
        "clock" = {
          format = "{:%a %d %b %H:%M}";
          tooltip = false;
        };
        "custom/vpn" = {
          interval = 1;
          on-click = ''
            tailscale up --accept-dns --exit-node=$(tailscale exit-node \
              list --filter="UK" |
              grep "London" |
              awk '{ print $2 }' |
              shuf -n 1
            )
          '';
          on-click-right = "tailscale up --accept-dns --exit-node=";
          exec = ../static/vpn.sh;
        };
        "hyprland/workspaces" = {
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
          sort-by-number = true;
        };
        "idle_inhibitor" = {
          format = " ";
          tooltip-format-activated = "Awake";
          tooltip-format-deactivated = "Sleeping";
        };
        "network" = {
          format = " ";
          on-click = "nm-connection-editor";
          tooltip-format = builtins.concatStringsSep "\n" [
            "Adapter: {ifname}"
            "Address: {ipaddr}"
            "Gateway: {gwaddr}"
          ];
          tooltip-format-wifi = builtins.concatStringsSep "\n" [
            "SSID:    {essid}"
            "Adapter: {ifname}"
            "Address: {ipaddr}"
            "Gateway: {gwaddr}"
          ];
        };
        pulseaudio = {
          format = " ";
          on-click = "hyprctl dispatch togglespecialworkspace media";
          on-click-right = "amixer set Master toggle";
          scroll-step = 5;
          tooltip-format = "Volume: {volume}%";
        };
      }
    ];
    style = builtins.replaceStrings [ "ICONS" ] [ (builtins.toString ../static/icons) ] (
      builtins.readFile ../static/styles/waybar.css
    );
  };
}
