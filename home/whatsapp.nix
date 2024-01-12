/*
* Firefox-based WhatsApp application.
*/

{ config, lib, ... }:

{
  # Create the Firefox profile
  programs.firefox.profiles.whatsapp = {
    id = 1;
    isDefault = false;
    settings = config.programs.firefox.profiles.default.settings // {
      "browser.sessionstore.resume_session_once" = false;
      "browser.sessionstore.resume_from_crash" = false;
      "browser.cache.disk.enable" = false;
      "browser.cache.disk.capacity" = 0;
      "browser.cache.disk.filesystem_reported" = 1;
      "browser.cache.disk.smart_size.enabled" = false;
      "browser.cache.disk.smart_size.first_run" = false;
      "browser.cache.disk.smart_size.use_old_max" = false;
      "browser.ctrlTab.previews" = true;
      "browser.tabs.warnOnClose" = false;
      "plugin.state.flash" = 2;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.tabs.allowTabDetach" = false;
      "browser.tabs.drawInTitlebar" = false;
      "browser.tabs.inTitlebar" = 0;
      "browser.tabs.tabmanager.enabled" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "network.cookie.lifetimePolicy" = 0;
    };
    userChrome = builtins.readFile ../static/css/web-app.css;
  };

  # Create the .desktop entry
  xdg.desktopEntries."WhatsApp" = {
    exec = lib.strings.concatStringsSep " " ([
      "${config.programs.firefox.package}/bin/firefox"
      "--class WhatsApp"
      "-P whatsapp"
      "--no-remote"
      "https://web.whatsapp.com"
    ]);
    icon = ../static/images/whatsapp.png;
    name = "WhatsApp";
    settings = {
      StartupWMClass = "WhatsApp";
      X-MultipleArgs = "false";
    };
    startupNotify = true;
    terminal = false;
    type = "Application";
  };
}
