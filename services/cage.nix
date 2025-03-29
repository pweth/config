/*
  * Wayland-based kiosk service.
  * https://github.com/cage-kiosk/cage
*/

{
  config,
  pkgs,
  ...
}:

{
  # Cage configuration
  services.cage = {
    enable = true;
    environment = {
      MOZ_ENABLE_WAYLAND = "0";
      WLR_LIBINPUT_NO_DEVICES = "1";
    };
    program = "${pkgs.firefox}/bin/firefox --kiosk --private-window https://start.duckduckgo.com";
    user = "pweth";
  };

  # Auto-login
  services.getty.autologinUser = config.services.cage.user;
}
