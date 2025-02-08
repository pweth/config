# * Locale configuration.

{ config, ... }:
let
  locale = "en_GB.UTF-8";
in
{
  # UK locale settings
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

  # UK keyboard layout
  services.xserver.xkb = {
    layout = "gb";
    options = "caps:escape";
  };

  # Set time zone to London
  time.timeZone = "Europe/London";
}
