{ pkgs, ... }:
let
  firefox-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherguy";
    repo = "firefox-csshacks";
    rev = "8c371d758a64099bb6711b98deb871b7474aa040";
    hash = "sha256-ZThxJ6/dH6dYieOLEwHYGivEG0gESoWUKoYu2FvEhgU=";
  };
  importChrome = file: "@import url('${firefox-csshacks}/chrome/${file}');";
in
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
      nativeMessagingHosts = with pkgs; [ _1password-gui bitwarden-desktop ];
      policies = import ./policies.nix;
      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;
        extraConfig = builtins.readFile ./prefs.cfg;
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
                    { name = "channel"; value = "unstable"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    { name = "channel"; value = "unstable"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
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
            "Docker Hub" = {
              urls = [
                {
                  template = "https://hub.docker.com/search";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://hub.docker.com/favicon.ico";
              definedAliases = [ "@docker" ];
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
        userChrome = ''
          ${importChrome "window_control_placeholder_support.css"}
          ${importChrome "hide_tabs_toolbar.css"}
          ${importChrome "button_effect_scale_onclick.css"}
          ${importChrome "blank_page_background.css"}
          ${importChrome "hide_toolbox_top_bottom_borders.css"}
          ${importChrome "vertical_context_navigation.css"}
          ${importChrome "minimal_popup_scrollbars.css"}
          ${importChrome "button_effect_icon_glow.css"}
          ${importChrome "dark_context_menus.css"}
          ${importChrome "dark_additional_windows.css"}
          ${importChrome "dark_checkboxes_and_radios.css"}
          ${importChrome "minimal_text_fields.css"}
          ${importChrome "minimal_toolbarbuttons.css"}
          ${importChrome "urlbar_centered_text.css"}
        '';
      };
    };
  };
}
