let
  lock = Value: {
    inherit Value;
    Status = "locked";
  };
  install = install_url: {
    inherit install_url;
    installation_mode = "force_installed";
  };
in
{
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
    "*" = {
      installation_mode = "blocked";
      blocked_install_message = "Add it to firefox/policies.nix to install it.";
    };
    "queryamoid@kaply.com" =
      install "https://github.com/mkaply/queryamoid/releases/download/v0.2/query_amo_addon_id-0.2-fx.xpi";
    "addon@darkreader.org" =
      install "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
    "uBlock0@raymondhill.net" =
      install "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    "jid1-MnnxcxisBPnSXQ@jetpack" =
      install "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
    "{3c078156-979c-498b-8990-85f7987dd929}" =
      install "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
    "{b743f56d-1cc1-4048-8ba6-f9c2ab7aa54d}" =
      install "https://addons.mozilla.org/firefox/downloads/latest/dracula-dark-colorscheme/latest.xpi";
    "{d634138d-c276-4fc8-924b-40a0ea21d284}" =
      install "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
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
  NewTabPage = false;
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
    "accessibility.force_disabled" = lock 1;
    "browser.aboutConfig.showWarning" = lock false;
    "browser.aboutHomeSnippets.updateUrl" = lock "";
    "browser.crashReports.unsubmittedCheck.autoSubmit2" = lock false;
    "browser.selfsupport.url" = lock "";
    "browser.startup.homepage" = lock "https://homepage.labs.adtya.xyz";
    "browser.startup.homepage_override.mstone" = lock "ignore";
    "browser.startup.homepage_override.buildID" = lock "";
    "browser.tabs.firefox-view" = lock false;
    "browser.tabs.firefox-view-next" = lock false;
    "browser.urlbar.suggest.history" = lock false;
    "browser.urlbar.suggest.topsites" = lock false;
    "dom.security.https_only_mode" = lock true;
    "extensions.htmlaboutaddons.recommendations.enabled" = lock false;
    "extensions.recommendations.themeRecommendationUrl" = lock "";
    "gfx.canvas.accelerated.cache-items" = lock 4096;
    "gfx.canvas.accelerated.cache-size" = lock 512;
    "gfx.content.skia-font-cache-size" = lock 20;
    "network.dns.disablePrefetch" = lock false;
    "network.dns.disablePrefetchFromHTTPS" = lock false;
    "network.http.max-connections" = lock 1800;
    "network.http.max-persistent-connections-per-server" = lock 10;
    "network.http.max-urgent-start-excessive-connections-per-host" = lock 5;
    "network.http.pacing.requests.enabled" = lock false;
    "network.IDN_show_punycode" = lock true;
    "network.predictor.enabled" = lock false;
    "network.prefetch-next" = lock false;
    "network.trr.mode" = lock 5;
    "signon.management.page.breach-alerts.enabled" = lock false;
    "widget.disable-swipe-tracker" = lock true;
  };
}
