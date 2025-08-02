/*
  * Waybar configuration.
  * https://github.com/Alexays/Waybar
*/

{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = [
      {
        modules-center = [ "clock" ];
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "network"
          "bluetooth"
          "pulseaudio"
        ];

        # Module configuration
        "bluetooth" = {
          format = " ";
          on-click = "blueman-manager";
          tooltip-format = builtins.concatStringsSep "\n" [
            "Status: {status}"
            "Devices: {num_connections}"
          ];
        };
        "clock" = {
          format = "{:%a %d %b %H:%M}";
          tooltip = false;
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
        "network" = {
          format = " ";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          tooltip-format = builtins.concatStringsSep "\n" [
            "Adapter: {ifname}"
            "Address: {ipaddr}"
            "Gateway: {gwaddr}"
          ];
          tooltip-format-wifi = builtins.concatStringsSep "\n" [
            "SSID: {essid}"
            "Adapter: {ifname}"
            "Address: {ipaddr}"
            "Gateway: {gwaddr}"
          ];
        };
        pulseaudio = {
          format = " ";
          on-click = "${pkgs.alsa-utils}/bin/amixer set Master toggle";
          on-click-right = "hyprctl dispatch togglespecialworkspace media";
          scroll-step = 5;
          tooltip-format = "Volume: {volume}%";
        };
      }
    ];
    style = (
      (builtins.readFile ../static/styles/waybar.css)
      + ''
        #bluetooth { background-image: url("${../static/icons/bluetooth.png}") }
        #network { background-image: url("${../static/icons/network.png}") }
        #pulseaudio { background-image: url("${../static/icons/audio.png}") }
        #pulseaudio.muted { background-image: url("${../static/icons/audio-mute.png}") }
      ''
    );
  };
}
