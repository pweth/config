/*
* Hyprland configuration.
* https://hyprland.org
*/

{ config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      cursor.no_hardware_cursors = true;
      exec-once = [
        "waybar &"
        "swww-daemon && swww img /etc/nixos/config/static/background.jpg &"
      ];
      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "GBM_BACKEND,nvidia-drm"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };
      gestures.workspace_swipe = true;
      input = {
        kb_layout = "gb";
        kb_options = "caps:escape";
        follow_mouse = 0;
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 4, default, popin 80%"
          "border, 1, 4, default"
          "borderangle, 1, 4, default"
          "fade, 1, 4, default"
          "workspaces, 1, 5, default"
          "specialWorkspace, 1, 5, default, slidevert"
        ];
      };
      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        middle_click_paste = false;
      };
      monitor = [
        "Unknown-1, disable"
      ];
      bind = [
        # Core
        "SUPER SHIFT, RETURN, exec, kitty"
        "SUPER, P, exec, wofi --show run"
        "SUPER, W, killactive"

        # Programs
        "SUPER, C, exec, galculator"
        "SUPER, E, exec, wofi-emoji"
        "SUPER, F, exec, firefox"
        "SUPER, L, exec, hyprlock"
        "SUPER, M, togglefloating"
        "SUPER SHIFT, S, exec, hyprshot -m region"
        ", Print, exec, hyprshot -m region"
        ", XF86EmojiPicker, exec, wofi-emoji"

        # Navigation
        "SUPER, Down, movefocus, d"
        "SUPER, Left, movefocus, l"
        "SUPER, O, togglesplit"
        "SUPER, Right, movefocus, r"
        "SUPER, Up, movefocus, u"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"

        "SUPER, SPACE, togglespecialworkspace, bottomSheet"
        "SUPER SHIFT, SPACE, movetoworkspace, special:bottomSheet"

        "SUPER, mouse_left, workspace, e-1"
        "SUPER, mouse_right, workspace, e+1"
      ];
      bindm = [
        "SUPER, mouse:273, movewindow"
      ];
      bindel = [
        ", XF86AudioLowerVolume, exec, amixer set Master 5%-"
        ", XF86AudioMute, exec, amixer set Master toggle"
        ", XF86AudioRaiseVolume, exec, amixer set Master 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
      ];
      windowrulev2 = [
        "float, class:galculator"
      ];
    };
  };
}
