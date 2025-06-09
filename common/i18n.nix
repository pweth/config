# * Internationalisation configuration.

{ config, pkgs, ... }:
let
  locale = "en_GB.UTF-8";
in
{
  # Default font packages
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "NotoColorEmoji" ];
        sansSerif = [ "NotoSans" ];
        serif = [ "NotoSerif" ];
        monospace = [ "FiraCode Nerd Font" ];
      };
    };
  };

  # Locale settings
  i18n = {
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = "gb";
    options = "caps:escape";
  };

  # Timezone
  time.timeZone = "Europe/London";
}
