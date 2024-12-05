{ pkgs, ... }: {
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
      };
    };
  };
}
