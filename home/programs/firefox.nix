_: {
  programs = {
    firefox = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          EmailTracking = true;
          Fingerprinting = true;
        };
        ExtensionSettings = {
          "{b743f56d-1cc1-4048-8ba6-f9c2ab7aa54d}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/dracula-dark-colorscheme/latest.xpi";
          };
          "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          };
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
        };
        FirefoxHome = {
          Search = true;
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
          StartPage = "previous-session";
          Locked = true;
        };
        NetworkPrediction = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        PasswordManagerEnabled = false;
        PrimaryPassword = false;
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
        Preferences = {
          "accessibility.force_disabled" = { Value = 1; Status = "locked"; };
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = { Value = false; Status = "locked"; };
          "browser.aboutConfig.showWarning" = { Value = false; Status = "locked"; };
          "browser.aboutHomeSnippets.updateUrl" = { Value = ""; Status = "locked"; };
          "browser.selfsupport.url" = { Value = ""; Status = "locked"; };
          "browser.startup.homepage_override.mstone" = { Value = "ignore"; Status = "locked"; };
          "browser.startup.homepage_override.buildID" = { Value = ""; Status = "locked"; };
          "browser.tabs.firefox-view" = { Value = false; Status = "locked"; };
          "browser.tabs.firefox-view-next" = { Value = false; Status = "locked"; };
          "browser.urlbar.suggest.history" = { Value = false; Status = "locked"; };
          "browser.urlbar.suggest.topsites" = { Value = false; Status = "locked"; };
          "dom.security.https_only_mode" = { Value = true; Status = "locked"; };
          "extensions.htmlaboutaddons.recommendations.enabled" = { Value = false; Status = "locked"; };
          "extensions.recommendations.themeRecommendationUrl" = { Value = ""; Status = "locked"; };
          "network.IDN_show_punycode" = { Value = true; Status = "locked"; };
          "network.trr.mode" = { Value = 5; Status = "locked"; };
          "signon.management.page.breach-alerts.enabled" = { Value = false; Status = "locked"; };
        };
      };
      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;
        search = {
          default = "DuckDuckGo";
          engines = {
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://nixos.org/favicon.ico";
              definedAliases = [ "@np" ];
            };
            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://nixos.org/favicon.ico";
              definedAliases = [ "@no" ];
            };
            "GitHub" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                    { name = "type"; value = "repositories"; }
                  ];
                }
              ];
              iconUpdateURL = "https://github.com/favicon.ico";
              definedAliases = [ "@gh" ];
            };
            "YouTube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    { name = "search_query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://www.youtube.com/favicon.ico";
              definedAliases = [ "@yt" ];
            };
          };
          force = true;
        };
        settings = {
          "app.shield.optoutstudies.enabled" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.firstparty.isolate" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "startup.homepage_override_url" = "";
          "startup.homepage_welcome_url" = "";
          "startup.homepage_welcome_url.additional" = "";
        };
      };
    };
  };
}
