/*
* Mozilla Firefox browser configuration.
*/

{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;

      # Browser extensions
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        df-youtube
        ublock-origin
      ];

      # Set default search engine to my themed DuckDuckGo and disable others
      search = {
        default = "DuckDuckGo Themed";
        force = true;
        engines = {
          "DuckDuckGo Themed" = {
            urls = [{
              # https://duckduckgo.com/duckduckgo-help-pages/settings/params/
              template = "https://duckduckgo.com/?q={searchTerms}&kp=1&kl=uk-en&kad=en_GB&k1=-1&kaj=m&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kae=d&k5=1";
            }];
            iconUpdateURL = "https://duckduckgo.com/favicon.png";
          };
          "Cowyo" = {
            urls = [{
              template = "https://cowyo.pw.ax/{searchTerms}";
            }];
            definedAliases = [ "!c" ];
            iconUpdateURL = "https://cowyo.com/static/img/cowyo/favicon-96x96.png";
          };
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages?channel=23.11&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";
            }];
            definedAliases = [ "!n" ];
            iconUpdateURL = "https://nixos.org/favicon.png";
          };
          "Amazon.co.uk".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };

      # Bookmarks toolbar
      bookmarks = [
        {
          name = "Bookmarks";
          toolbar = true;
          bookmarks = [
            {
              name = "Moodle";
              keyword = "!m";
              url = "https://moodle.bath.ac.uk/login/index.php";
            }
            {
              name = "Fastmail";
              keyword = "!fm";
              url = "https://app.fastmail.com/mail/Inbox/";
            }
            {
              name = "Outlook";
              keyword = "!o";
              url = "https://outlook.office365.com/mail/";
            }
            {
              name = "Cloudflare";
              keyword = "!cf";
              url = "https://dash.cloudflare.com/";
            }
            {
              name = "GitHub";
              keyword = "!gh";
              url = "https://github.com/";
            }
            {
              name = "Jupyter";
              keyword = "!j";
              url = "https://notebook.pw.ax/";
            }
            {
              name = "Wordle";
              keyword = "!wordle";
              url = "https://www.nytimes.com/games/wordle/index.html";
            }
          ];
        }
      ];

      # about:config values
      settings = {
        # Disable warning
        "browser.aboutConfig.showWarning" = false;

        # Set home page
        "browser.startup.page" = 1;
        "browser.startup.homepage" = "about:blank";

        # Dark theme
        "layout.css.prefers-color-scheme.content-override" = 0;

        # Speed improvements
        "content.notify.interval" = 100000;
        "gfx.canvas.accelerated.cache-items" = 4096;
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;
        "browser.cache.jsbc_compression_level" = 3;
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;
        "image.mem.decode_bytes_at_a_time" = 32768;
        "network.buffer.cache.size" = 262144;
        "network.buffer.cache.count" = 128;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheExpiration" = 3600;
        "network.dns.max_high_priority_threads" = 8;
        "network.ssl_tokens_cache_capacity" = 10240;
        "network.dns.disablePrefetch" = true;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;
        "layout.css.grid-template-masonry-value.enabled" = true;
        "dom.enable_web_task_scheduling" = true;
        "layout.css.has-selector.enabled" = true;
        "dom.security.sanitizer.enabled" = true;

        # Disable Firefox Sync
        "identity.fxaccounts.enabled" = false;

        # Disable Firefox View
        "browser.tabs.firefox-view" = false;
        "browser.tabs.firefox-view-next" = false;
        "browser.firefox-view.feature-tour" = "{\"screen\":\"\",\"complete\":true}";

        # Disable Activity Stream
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

        # Protect/disable specific APIs
        "dom.battery.enabled" = false;
        "dom.event.clipboardevents.enabled" = true;
        "dom.event.contextmenu.enabled" = true;
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
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;

        # Bookmarks toolbar
        "browser.toolbars.bookmarks.visibility" = "always";

        # Skip Firefox welcome pages
        "browser.aboutwelcome.enabled" = false;
        "startup.homepage_welcome_url" = "about:blank";

        # Disable autofill
        "dom.forms.autocomplete.formautofill" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "security.ask_for_password" = 0;
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;

        # Disable thumbnail collection
        "browser.pagethumbnails.capturing_disabled" = true;

        # Delete temporary files opened in external apps
        "browser.helperApps.deleteTempFileOnExit" = true;

        # Disable installed plugins list
        "plugins.enumerable_names" = "";

        # TLS settings
        "dom.security.https_only_mode" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;

        # Send limited referer only if hosts match
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        # Downloads
        "browser.download.useDownloadDir" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.always_ask_before_handling_new_types" = true;

        # Enable ETP and RFP
        "browser.contentblocking.category" = "strict";
        "privacy.partition.serviceWorkers" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = true;
        "privacy.resistFingerprinting" = true;

        # Disable Pocket
        "extensions.pocket.enabled" = false;

        # Disable experiments
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
      };
    };
  };
}
