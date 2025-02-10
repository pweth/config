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
          on-click = "amixer set Master toggle";
          on-click-right = "hyprctl dispatch togglespecialworkspace media";
          scroll-step = 5;
          tooltip-format = "Volume: {volume}%";
        };
      }
    ];
    style = ((builtins.readFile ../static/styles/waybar.css) + ''
      #bluetooth { background-image: url("${../static/icons/bluetooth.png}") }
      #custom-vpn { background-image: url("${../static/icons/vpn-deactivated.png}") }
      #custom-vpn.activated { background-image: url("${../static/icons/vpn-activated.png}") }
      #idle_inhibitor { background-image: url("${../static/icons/idle-deactivated.png}") }
      #idle_inhibitor.activated { background-image: url("${../static/icons/idle-activated.png}") }
      #network { background-image: url("${../static/icons/network.png}") }
      #pulseaudio { background-image: url("${../static/icons/audio.png}") }
      #pulseaudio.muted { background-image: url("${../static/icons/audio-mute.png}") }
   '');
  };
}
