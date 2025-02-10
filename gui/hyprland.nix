/*
  * Hyprland configuration.
  * https://hyprland.org
*/

{ config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      animations.enabled = false;
      cursor.no_hardware_cursors = true;
      decoration.rounding = 5;
      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "GBM_BACKEND,nvidia-drm"
        "LIBGL_ALWAYS_SOFTWARE,1"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "__GL_THREADED_OPTIMIZATIONS,0"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      exec-once = [
        "hyprpaper"
        "hyprctl setcursor Adwaita 24"
        "[workspace special:browser silent] firefox"
        "[workspace special:media silent] sleep 15; spotify"
      ];
      general = {
        allow_tearing = false;
        border_size = 0;
        gaps_in = 10;
        gaps_out = 20;
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
      bind = [
        # Core
        "SUPER SHIFT, RETURN, exec, kitty tmux"
        "SUPER, P, exec, eval $(compgen -ac | sort | uniq | grep -E '^[0-9A-Za-z]+' | wofi)"
        "SUPER, W, killactive"

        # Programs
        "SUPER, C, exec, galculator"
        "SUPER, E, exec, pcmanfm"
        "SUPER, F, exec, firefox"
        "SUPER, L, exec, hyprlock"
        "SUPER SHIFT, S, exec, hyprshot -m region"
        ", Print, exec, hyprshot -m region"
        "SUPER, PERIOD, exec, wofi-emoji"

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
        "CTRL SUPER SHIFT, P, exec, shutdown now"
        "CTRL SUPER SHIFT, R, exec, shutdown now --reboot"
      ];
      bindm = [ "SUPER, mouse:273, movewindow" ];
      bindel = [
        ", XF86AudioLowerVolume, exec, amixer set Master 5%-"
        ", XF86AudioMute, exec, amixer set Master toggle"
        ", XF86AudioRaiseVolume, exec, amixer set Master 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
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
