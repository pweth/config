{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        # Set default search engine to DuckDuckGo and disable others
        search.default = "DuckDuckGo";
        search.engines = {
          "Amazon.co.uk".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
        search.force = true;

        # about:config settings
        # Source: https://brainfucksec.github.io/firefox-hardening-guide
        settings = {
          # Disable about:config warning
          "browse.aboutConfig.warning" = false;


          # # Change Enhanced Tracking Protection to strict
          # "browser.contentblocking.category" = "strict";

          # # Disable new tab page
          # "browser.newtab.url" = "about:blank";
          # "browser.newtabpage.enabled" = false;

          # # Set search region to UK
          # "browser.search.region" = "GB";
          # "browser.search.isUS" = false;

          # # Set home page
          # "browser.startup.homepage" = "https://start.duckduckgo.com";

          # # Disable certain APIs
          # "dom.battery.enabled" = false;
          # "dom.gamepad.enabled" = false;

          # # Disable experiments
          # "experimens.activeExperiment" = false;
          # "experiments.enabled" = false;
          # "experiments.manifest.uri" = "";
          # "experiments.supported" = false;
          # "network.allow-experiments" = false;

          # # Disable pocket
          # "extensions.pocket.enabled" = false;

          # # Privacy settings
          # "privacy.donottrackheader.enabled" = true;
          # "privacy.donottrackheader.value" = 1;
          # "privacy.purge_trackers.enable" = true;

          # # Disable the built-in password manager
          # "signon.rememberSignons" = false;

          # # Disable telemetry
          # # TODO
        };
      };
    };
  };
}
