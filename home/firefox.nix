{ config, pkgs, ... }:
let
  # duckduckgo.com/duckduckgo-help-pages/settings/params/
  ddgSettings = "kp=1&kl=uk-en&kad=en_GB&k1=-1&kaj=m&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kae=d&k5=1";
in
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;

      # Set default search engine to my themed DuckDuckGo and disable others
      search.default = "DDG";
      search.force = true;
      search.engines = {
        "DDG" = {
          urls = [{
            template = "https://duckduckgo.com/?q={searchTerms}&${ddgSettings}";
          }];
          # Update icon once a day
          iconUpdateURL = "https://duckduckgo.com/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000;
        };
        "Amazon.co.uk".metaData.hidden = true;
        "Bing".metaData.hidden = true;
        "DuckDuckGo".metaData.hidden = true;
        "eBay".metaData.hidden = true;
        "Google".metaData.hidden = true;
        "Wikipedia (en)".metaData.hidden = true;
      };

      bookmarks = [
        {
          name = "GitHub";
          keyword = "!gh";
          url = "https://github.com/";
        }
        # TODO
      ];

      # about:config values
      settings = {
        # Disable about:config warning
        "browser.aboutConfig.showWarning" = false;

        # Set home page
        "browser.startup.page" = 1;
        "browser.startup.homepage" = "about:blank";

        # Dark theme
        "layout.css.prefers-color-scheme.content-override" = 0;

        # Disable Activity Stream
        # brainfucksec.github.io/firefox-hardening-guide
        "browser.newtabpage.enabled" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.sections.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

        # Do not track
        "privacy.donottrackheader.enabled" = true;

        # Language settings
        "intl.accept_languages" = "en-US, en";
        "javascript.use_us_english_locale" = true;

        # Disable add-on recommendations
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;

        # Disable specific APIs
        "dom.battery.enabled" = false;
        "dom.gamepad.enabled" = false;

        # Disable telemetry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.ping-centre.telemetry" = false;
        "beacon.enabled" = false;

        # Disable studies and Normandy/Shield
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        # Disable crash reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;

        # Use Punycode
        "network.IDN_show_punycode" = true;

        # Disable search suggestions
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.trimURLs" = false;
        "browser.urlbar.quicksuggest.scenario" = "history";
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;

        # Disable autofill
        "dom.forms.autocomplete.formautofill" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;

        # Disable thumbnail collection
        "browser.pagethumbnails.capturing_disabled" = true;

        # Delete temporary files opened in external apps
        "browser.helperApps.deleteTempFileOnExit" = true;

        # TLS settings
        "dom.security.https_only_mode" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;

        # Send limited referer only if hosts match
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        # Downloads
        "browser.download.useDownloadDir" = false;
        "browser.download.manager.addToRecentDocs" = false;

        # Enable ETP and RFP
        "browser.contentblocking.category" = "strict";
        "privacy.partition.serviceWorkers" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = true;
        "privacy.resistFingerprinting" = true;

        # Disable Pocket
        "extensions.pocket.enabled" = false;

        # Only retain active logins and cookies
        "places.history.enabled" = false;
        "privacy.history.custom" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.sanitize.pending" = "[{\"id\":\"shutdown\",\"itemsToClear\":[\"cache\",\"history\",\"formdata\",\"downloads\"],\"options\":{}},{\"id\":\"newtab-container\",\"itemsToClear\":[],\"options\":{}}]";
      };
    };
  };
}
