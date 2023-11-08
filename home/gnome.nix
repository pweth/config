/*
* GNOME desktop environment configuration.
*/

{ config, pkgs, lib, ... }:

{
  # User icon
  home.file.".face".source = ../static/profile.png;

  # Theme
  home.file.".themes/pweth/gnome-shell/gnome-shell.css".source = ../static/gnome-shell.css;

  # Extensions to install
  home.packages = with pkgs.gnomeExtensions; [
    vitals
  ];

  # dconf values
  dconf = {
    enable = true;
    settings = {
      # General settings
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/pweth/dotfiles/static/background.jpg";
        picture-uri-dark = "file:///home/pweth/dotfiles/static/background.jpg";
      };
      "org/gnome/desktop/calendar" = {
        show-weekdate = false;
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
        picture-uri = "file:///home/pweth/dotfiles/static/background.jpg";
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
      "org/gnome/shell" = {
        app-picker-layout = [];
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "Vitals@CoreCoding.com"
        ];
        disable-user-extensions = false;
        favorite-apps = [];
      };

      # Extension settings
      "org/gnome/shell/extensions/user-theme" = {
        name = "pweth";
      };
      "org/gnome/shell/extensions/vitals" = {
        alphabetize = false;
        fixed-widths = false;
        hide-icons = true;
        hot-sensors = [ "_processor_usage_" "_memory_allocated_" ];
        show-fan = false;
        show-network = false;
        show-system = false;
        show-temperature = false;
        show-voltage = false;
      };

      # Emote keyboard shortcut
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>period";
        command = "emote";
        name = "Emote";
      };

      # File explorer settings
      "org/gnome/nautilus/list-view" = {
        default-zoom-level = "medium";
      };
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
      };
      "org/gtk/gtk4/settings/file-chooser" = {
        sort-directories-first = true;
      };
    };
  };
}
