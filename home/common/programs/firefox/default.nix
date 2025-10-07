{ pkgs, ... }:
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox.override {
        extraPolicies = import ./policies.nix;
        extraPrefs = builtins.readFile ./prefs.cfg;
      };
      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;
        # https://github.com/hyprwm/Hyprland/discussions/10355
        userChrome = ''
          /* Reduce minimum window width for firefox */
          :root:not([chromehidden~="toolbar"]){
            min-width: 20px !important;
          }
        '';
        search = {
          default = "ddg";
          engines = {
            "bing".metaData.hidden = true;
            "google".metaData.hidden = true;
            "ProtonDB" = {
              urls = [
                {
                  template = "https://www.protondb.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://www.protondb.com//favicon.ico";
              definedAliases = [ "@game" ];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "sort";
                      value = "alpha_asc";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
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
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "sort";
                      value = "alpha_asc";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
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
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                    {
                      name = "type";
                      value = "repositories";
                    }
                  ];
                }
              ];
              icon = "https://github.com/favicon.ico";
              definedAliases = [ "@gh" ];
            };
            "Docker Hub" = {
              urls = [
                {
                  template = "https://hub.docker.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://hub.docker.com/favicon.ico";
              definedAliases = [ "@docker" ];
            };
            "youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://www.youtube.com/favicon.ico";
              definedAliases = [ "@yt" ];
            };
          };
          force = true;
        };
      };
    };
  };
}
