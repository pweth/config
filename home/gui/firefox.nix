/*
* Mozilla Firefox browser configuration.
* https://mozilla.github.io/policy-templates/
*/

{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    policies = {
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "never";
      DNSOverHTTPS = {
        Enabled = false;
        Locked = true;
      };
      EnableTrackingProtection = {
        Cryptomining = true;
        Fingerprinting = true;
        Locked = true;
        Value = true;
      };
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          default_area = "navbar";
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          default_area = "navbar";
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
      };
      ExtensionUpdate = true;
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      Homepage = {
        Locked = true;
        StartPage = "homepage-locked";
        URL = "about:blank";
      };
      NewTabPage = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      PDFjs = {
        Enabled = true;
        EnablePermissions = false;
      };
      Permissions = {
        Notifications = {
          BlockNewRequests = true;
          Locked = true;
        };
      };
      Proxy = {
        Locked = true;
        Mode = "none";
      };
      RequestedLocales = "en-US,en";
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false;
        Downloads = true;
        FormData = true;
        History = false;
        Sessions = false;
        SiteSettings = false;
        OfflineApps = false;
        Locked = true;
      };
      SearchBar = "unified";
      SearchEngines.PreventInstalls = true;
      SearchSuggestEnabled = false;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = true;
      };
    };

    profiles.default = {
      id = 0;
      isDefault = true;

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
          "Notes" = {
            urls = [{
              template = "https://notes.pweth.com/search?term={searchTerms}";
            }];
            definedAliases = [ "!c" ];
            iconUpdateURL = "https://raw.githubusercontent.com/dullage/flatnotes/develop/client/assets/favicon-32x32.png";
          };
          "Fastmail" = {
            urls = [{
              template = "https://app.fastmail.com/mail/search:{searchTerms}/";
            }];
            definedAliases = [ "!fm" ];
            iconUpdateURL = "https://app.fastmail.com/static/favicons/icon-32x32.png";
          };
          "GitHub Code" = {
            urls = [{
              template = "https://github.com/search?q={searchTerms}&type=code";
            }];
            definedAliases = [ "!ghc" ];
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon.png";
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

      # about:config values
      settings = {
        # Enable userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Do not track
        "browser.pagethumbnails.capturing_disabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;

        # Protect/disable specific APIs
        "dom.battery.enabled" = false;
        "dom.event.clipboardevents.enabled" = true;
        "dom.event.contextmenu.enabled" = true;
        "dom.gamepad.enabled" = false;
        "plugins.enumerable_names" = "";

        # Encrypted SNI
        "network.security.esni.enabled" = true;

        # Use Punycode
        "network.IDN_show_punycode" = true;

        # Disable search suggestions
        "browser.urlbar.trimURLs" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;

        # Download settings
        "browser.download.useDownloadDir" = false;
        "browser.helperApps.deleteTempFileOnExit" = true;        

        # TLS settings
        "dom.security.https_only_mode" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;

        # Send limited referer only if hosts match
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
      };

      userChrome = builtins.readFile ../../static/css/firefox.css;
    };
  };
}
