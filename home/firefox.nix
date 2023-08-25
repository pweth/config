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
        settings = {
          # Change Enhanced Tracking Protection to strict
          "browser.contentblocking.category" = "strict";

          # Disable new tab page
          "browser.newtab.url" = "about:blank";
          "browser.newtabpage.activity-stream.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.enabled" = false;
          "browser.ping-centre.telemetry" = false;

          # Set search region to UK
          "browser.search.region" = "GB";
          "browser.search.isUS" = false;

          # Set home page
          "browser.startup.homepage" = "https://start.duckduckgo.com";

          # Clean up the URL bar
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.shortcuts.tabs" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.searches" = false;

          # Disable health reports
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;

          # Dev tools theme
          "devtools.theme" = "dark";

          # Disable battery and gamepad APIs
          "dom.battery.enabled" = false;
          "dom.gamepad.enabled" = false;

          # Disable experiments
          "experimens.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "experiments.supported" = false;
          "network.allow-experiments" = false;

          # Disable pocket
          "extensions.pocket.enabled" = false;

          # Privacy settings
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.purge_trackers.enable" = true;

          # Disable the built-in password manager
          "signon.rememberSignons" = false;

          # Disable telemetry
          "toolkit.coverage.endpoint.base" = "";
          "toolkit.coverage.opt-out" = true;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.eabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
        };
      };
    };
  };
}
