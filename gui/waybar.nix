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
        "bluetooth"
        "network"
      ];

      # Module configuration
      "clock" = {
        format = "{:%a %d %b %H:%M}";
        tooltip = false;
      };
      "hyprland/workspaces" = {
        all-outputs = true;
        sort-by-number = true;
      };
    }];
    style = ''
      * {
        font-family: Hack, monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(17, 17, 17, 1);
        border: none;
        color: white;
      }

      #clock {
        background: transparent;
        padding: 10px;
      }
    '';
  };
}
