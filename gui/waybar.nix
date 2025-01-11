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
        on-click = "hyprctl dispatch togglespecialworkspace media";
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
    style = builtins.replaceStrings ["ICONS"] [
      (builtins.toString ../static/icons)
     ] (builtins.readFile ../static/styles/waybar.css);
  };
}
