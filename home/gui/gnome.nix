/*
* GNOME desktop environment configuration.
*/

{ config, lib, pkgs, user, ... }:

{
  # User icon
  home.file.".face".source = ../../static/images/profile.png;

  # Theme
  home.file.".themes/${user}/gnome-shell/gnome-shell.css".source = ../../static/css/gnome-shell.css;

  # Extensions
  home.packages = with pkgs.gnomeExtensions; [
    caffeine
  ];

  # dconf values
  dconf = {
    enable = true;
    settings = {
      # General settings
      "org/gnome/desktop/background" = {
        picture-uri = "file:///etc/nixos/config/static/images/background.jpg";
        picture-uri-dark = "file:///etc/nixos/config/static/images/background.jpg";
      };
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };
      "org/gnome/desktop/input-sources" = {
        sources = [
          (lib.hm.gvariant.mkTuple [ "xkb" "gb" ])
          (lib.hm.gvariant.mkTuple [ "xkb" "gb+dvorakukp" ])
        ];
      };
      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        gtk-enable-primary-paste = false;
        gtk-theme = "Adwaita-dark";
        monospace-font-name = "Hack 11";
        show-battery-percentage = true;
        text-scaling-factor = 1.3;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        click-method = "areas";
      };
      "org/gnome/desktop/notifications" = {
        show-in-lock-screen = false;
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///etc/nixos/config/static/images/background.jpg";
        user-switch-enabled = false;
      };
      "org/gnome/desktop/session" = {
        idle-delay = 900;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,close";
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-automatic = true;
        night-light-temperature = 1700;
      };
      "org/gnome/shell" = {
        app-picker-layout = [];
        enabled-extensions = [
          "caffeine@patapon.info"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
        disable-user-extensions = false;
        favorite-apps = [];
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = user;
      };

      # Custom keyboard shortcuts
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>period";
        command = "emote";
        name = "Emote";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>Return";
        command = "kgx";
        name = "Console";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "<Super>f";
        command = "firefox";
        name = "Firefox";
      };

      # Other keyboard shortcuts
      "org/gnome/desktop/vm/keybindings" = {
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
      };
      "org/gnome/mutter/wayland/keybindings" = {
        restore-shortcuts = [];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        calculator = [ "<Super>c" ];
        help = [];
        home = [ "<Super>e" ];
      };
      "org/gnome/shell/keybindings" = {
        show-screen-recording-ui = [ "<Control><Super>s" ];
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
      };

      # Caffeine settings
      "org/gnome/shell/extensions/caffeine" = {
        enable-fullscreen = false;
        show-indicator = "always";
        show-notifications = false;
      };
    };
  };
}
