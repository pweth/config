/*
* Firefox-based web applications.
*/

{ config, lib, ... }:
let
  apps = [
    { id = 1; name = "WhatsApp"; url = "https://web.whatsapp.com"; icon = ../static/images/whatsapp.png; }
  ];
in
{
  # Create the Firefox profiles
  programs.firefox.profiles = builtins.listToAttrs (builtins.map (app: {
    name = app.name;
    value = {
      id = app.id;
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
  }) apps);

  # Create the .desktop entries
  xdg.desktopEntries = builtins.listToAttrs (builtins.map (app: {
    name = app.name;
    value = {
      exec = lib.strings.concatStringsSep " " ([
        "${config.programs.firefox.package}/bin/firefox"
        "--class ${app.name}"
        "-P ${app.name}"
        "--no-remote"
        "${app.url}"
      ]);
      icon = app.icon;
      name = app.name;
      settings = {
        StartupWMClass = app.name;
        X-MultipleArgs = "false";
      };
      startupNotify = true;
      terminal = false;
      type = "Application";
    };
  }) apps);
}
