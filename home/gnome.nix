{ config, pkgs, ... }:

{
  # Gnome packages and extensions to install
  home.packages = with pkgs; [
    gnome.eog
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.gnome-bedtime
    gnomeExtensions.just-perfection
    gnomeExtensions.vitals
  ];

  # dconf values
  dconf = {
    enable = true;
    settings = {
      # General settings
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/pweth/dotfiles/assets/background.jpg";
        picture-uri-dark = "file:///home/pweth/dotfiles/assets/background.jpg";
      };
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };
      "org/gnome/desktop/input-sources" = {
        sources = [
          lib.hm.gvariant.mkTuple ["xkb" "gb"]
          lib.hm.gvariant.mkTuple ["xkb" "gb+dvorakukp"]
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
        picture-uri = "file:///home/pweth/dotfiles/assets/background.jpg";
        user-switch-enabled = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,close";
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
      };
      "org/gnome/shell" = {
        # `gnome-extensions list`
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "caffeine@patapon.info"
          "gnomebedtime@ionutbortis.gmail.com"
          "just-perfection-desktop@just-perfection"
          "Vitals@CoreCoding.com"
        ];
        disable-user-extensions = false;
        favorite-apps = [];
      };

      # Extension settings
      "org/gnome/shell/extensions/bedtime-mode" = {
        bedtime-mode-active = false;
      };
      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur = true;
      };
      "org/gnome/shell/extensions/just-perfection" = {
        accessibility-menu = false;
        activities-button = false;
        background-menu = false;
        events-button = false;
        search = false;
        show-apps-button = false;
        window-menu-take-screenshot-button = false;
        world-clock = false;
      };
      "org/gnome/shell/extensions/vitals" = {
        alphabetize = false;
        fixed-widths = false;
        hot-sensors = [ "_processor_usage_" "_memory_allocated_" "_storage_used_" ];
        show-battery = true;
        show-fan = false;
        show-system = false;
      };
    };
  };
}
