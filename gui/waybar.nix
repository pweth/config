/*
* Waybar configuration.
* https://github.com/Alexays/Waybar
*/

{ config, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "idle_inhibitor"
        "custom/media"
        "bluetooth"
        "network"
      ];

      # Module configuration
      "bluetooth" = {
        format = " ";
        format-disabled = "";
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
      "custom/media" = {
        interval = 1;
        on-click = "hyprctl dispatch togglespecialworkspace music";
        on-click-right = "playerctl play-pause";
        exec = ../static/media.sh;
      };
      "hyprland/workspaces" = {
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
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
    }];
    style = ''
      * {
        font-family: Hack Nerd Font;
        font-size: 16px;
        min-height: 0;
      }

      window#waybar {
        background: #111111;
        border: none;
        color: white;
      }

      #workspaces {
        background: transparent;
        padding: 0;
      }

      #workspaces button {
        background: transparent;
        border: none;
        border-radius: 0;
        border-top: solid 2px #111111;
        box-shadow: none;
        padding: 10px 8px;
      }

      #workspaces button.active, #workspaces button:hover {
        background: #000000;
      }

      #workspaces button:not(.empty) {
        border-color: #777777;
      }

      #workspaces button:not(.empty).active {
        border-color: #FFFFFF;
      }

      #bluetooth, #clock, #custom-media, #idle_inhibitor, #network {
        background: transparent;
        border-top: solid 2px #111111;
        padding: 10px 15px;
      }

      #bluetooth, #custom-media, #idle_inhibitor, #network {
        background-color: transparent;
        background-position: center;
        background-repeat: no-repeat;
        background-size: 16px;
        border-color: #777777;
      }

      #bluetooth:hover, #custom-media:hover, #idle_inhibitor:hover, #network:hover {
        background-color: #000000;
      }

      #bluetooth.connected,
      #custom-media.activated,
      #idle_inhibitor.activated,
      #network.ethernet,
      #network.linked,
      #network.wifi {
        border-color: #FFFFFF;
      }

      #bluetooth {
        background-image: url("${../static/icons/bluetooth.png}");
      }

      #custom-media {
        background-image: url("${../static/icons/media.png}");
      }

      #idle_inhibitor {
        background-image: url("${../static/icons/idle-deactivated.png}");
      }

      #idle_inhibitor.activated {
        background-image: url("${../static/icons/idle-activated.png}");
      }

      #network {
        background-image: url("${../static/icons/network.png}");
      }
    '';
  };
}
