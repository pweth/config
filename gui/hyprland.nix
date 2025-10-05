/*
  * Hyprland configuration.
  * https://hyprland.org
*/

{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      animations.enabled = false;
      cursor.no_hardware_cursors = true;
      decoration.rounding = 5;
      ecosystem.no_update_news = true;
      exec-once = with pkgs; [
        "${hyprpaper}/bin/hyprpaper"
        "[workspace special:browser silent] firefox"
        "[workspace special:media silent] sleep 15; ${spotify}/bin/spotify"
      ];
      general = {
        allow_tearing = false;
        border_size = 0;
        gaps_in = 10;
        gaps_out = 0;
        hover_icon_on_border = false;
        layout = "dwindle";
        no_border_on_floating = true;
        resize_on_border = true;
      };
      gestures.workspace_swipe = true;
      input = {
        kb_layout = "gb";
        kb_options = "caps:escape";
        follow_mouse = 0;
        numlock_by_default = true;
      };
      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        middle_click_paste = false;
      };
      monitor = [
        ", preferred, auto, 1.25"
        "Unknown-1, disable"
      ];
      render.explicit_sync = 0;
      bind = with pkgs; [
        # Core
        "SUPER SHIFT, RETURN, exec, kitty tmux"
        "SUPER, P, exec, eval $(compgen -ac | sort -u | grep -E '^[0-9A-Za-z]+' | wofi)"
        "SUPER, W, killactive"

        # Programs
        "SUPER, C, exec, ${galculator}/bin/galculator"
        ", XF86Calculator, exec, ${galculator}/bin/galculator"
        "SUPER, E, exec, ${pcmanfm}/bin/pcmanfm"
        "SUPER, F, exec, firefox"
        "SUPER, L, exec, ${hyprlock}/bin/hyprlock"
        "SUPER SHIFT, S, exec, ${hyprshot}/bin/hyprshot -m region"
        ", Print, exec, ${hyprshot}/bin/hyprshot -m region"
        "SUPER, PERIOD, exec, ${wofi-emoji}/bin/wofi-emoji"

        # Navigation
        "SUPER, M, togglefloating"
        "SUPER, O, togglesplit"

        # Workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        ", mouse:275, workspace, e-1"
        ", mouse:276, workspace, e+1"

        "SUPER, S, togglespecialworkspace, media"
        "SUPER, SPACE, togglespecialworkspace, overlay"
        "SUPER SHIFT, SPACE, movetoworkspace, special:overlay"

        # Power control
        "CTRL SUPER SHIFT, P, exec, ${systemd}/bin/shutdown now"
        "CTRL SUPER SHIFT, R, exec, ${systemd}/bin/shutdown now --reboot"
      ];
      bindm = [ "SUPER, mouse:273, movewindow" ];
      bindel = with pkgs; [
        ", XF86AudioLowerVolume, exec, ${alsa-utils}/bin/amixer set Master 5%-"
        ", XF86AudioMute, exec, ${alsa-utils}/bin/amixer set Master toggle"
        ", XF86AudioRaiseVolume, exec, ${alsa-utils}/bin/amixer set Master 5%+"
        ", XF86MonBrightnessDown, exec, ${brightnessctl}/bin/brightnessctl set 10%-"
        ", XF86MonBrightnessUp, exec, ${brightnessctl}/bin/brightnessctl set 10%+"
      ];
      windowrulev2 = [
        "float, class:blueman-manager"
        "float, class:galculator"
        "float, class:nm-connection-editor"
        "float, class:pcmanfm"
        "size 960 720, class:pcmanfm"
        "float, title:(Open File|Open Folder)"
      ];
      xwayland.force_zero_scaling = true;
    };
  };

  # Wallpaper configuration
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${../static/background.jpg}
    wallpaper = , ${../static/background.jpg}
  '';
}
