let
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
    "uBlock0@raymondhill.net" =
      install "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    "jid1-MnnxcxisBPnSXQ@jetpack" =
      install "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
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
}
