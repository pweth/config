{ config, pkgs, ... }:

{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/pweth/dotfiles/assets/background.jpg";
        picture-uri-dark = "file:///home/pweth/dotfiles/assets/background.jpg";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
        text-scaling-factor = 1.3;
      };
      "org/gnome/desktop/notifications" = {
        show-in-lock-screen = false;
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
      };
    };
  };
}
