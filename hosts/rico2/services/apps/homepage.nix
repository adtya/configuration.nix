{ config, ... }:
let
  domainName = "homepage.labs.adtya.xyz";
  cfg = config.services.glance;
in
{
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        extraConfig = ''
          reverse_proxy ${cfg.settings.server.host}:${toString cfg.settings.server.port}
        '';
      };
    };
    glance = {
      enable = true;
      settings = {
        server = {
          host = "127.0.0.1";
          port = 5678;
        };
        theme = {
          background-color = "240 21 15";
          contrast-multiplier = 1.2;
          primary-color = "217 92 83";
          positive-color = "115 54 76";
          negative-color = "347 70 65";
        };
        pages = [
          {
            name = "Startpage";
            width = "slim";
            hide-desktop-navigation = true;
            center-vertically = true;
            columns = [
              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                    autofocus = true;
                    search-engine = "duckduckgo";
                    bangs = [
                      { title = "YouTube"; shortcut = "!yt"; url = "https://www.youtube.com/results?search_query={QUERY}"; }
                      { title = "NixOS Options"; shortcut = "!no"; url = "https://search.nixos.org/options?channel=unstable&query={QUERY}"; }
                      { title = "Nix Packages"; shortcut = "!np"; url = "https://search.nixos.org/packages?channel=unstable&query={QUERY}"; }
                      { title = "GitHub"; shortcut = "!gh"; url = "https://github.com/search?q={QUERY}&type=repositories"; }
                      { title = "DockerHub"; shortcut = "!docker"; url = "https://hub.docker.com/search?q={QUERY}"; }
                    ];
                  }
                  {
                    type = "monitor";
                    cache = "1m";
                    title = "Services";
                    sites = [
                      { title = "Jellyfin"; url = "https://jellyfin.labs.adtya.xyz/"; icon = "si:jellyfin"; same-tab = true; }
                      { title = "Forgejo"; url = "https://git.ironyofprivacy.org/"; icon = "si:forgejo"; same-tab = true; }
                      { title = "Transmission"; url = "https://transmission.labs.adtya.xyz/"; icon = "si:transmission"; }
                      { title = "Prowlarr"; url = "https://prowlarr.labs.adtya.xyz/"; icon = "si:prowlarr"; }
                      { title = "Bazarr"; url = "https://bazarr.labs.adtya.xyz/"; icon = "si:bazarr"; same-tab = true; }
                      { title = "Radarr"; url = "https://radarr.labs.adtya.xyz/"; icon = "si:radarr"; same-tab = true; }
                      { title = "Sonarr"; url = "https://sonarr.labs.adtya.xyz/"; icon = "si:sonarr"; same-tab = true; }
                      { title = "Lidarr"; url = "https://lidarr.labs.adtya.xyz/"; icon = "si:lidarr"; same-tab = true; }
                    ];
                  }

                  {
                    type = "bookmarks";
                    groups = [
                      {
                        title = "Homelab";
                        links = [
                          { title = "Grafana"; url = "https://grafana.labs.adtya.xyz/"; icon = "si:grafana"; same-tab = true; }
                          { title = "Prometheus"; url = "https://prometheus.labs.adtya.xyz/"; icon = "si:prometheus"; same-tab = true; }
                          { title = "Alert Manager"; url = "https://alertmanager.labs.adtya.xyz/"; icon = "si:prometheus"; same-tab = true; }
                        ];
                      }
                      {
                        title = "General";
                        links = [
                          { title = "Email"; url = "https://app.fastmail.com/mail/Inbox/"; icon = "si:fastmail"; same-tab = true; }
                          { title = "GitHub Notifications"; url = "https://github.com/notifications"; icon = "si:github"; same-tab = true; }
                          { title = "Nixpkgs PR Tracker"; url = "https://nixpk.gs/pr-tracker.html"; icon = "si:nixos"; same-tab = true; }
                          { title = "DigitalOcean"; url = "https://cloud.digitalocean.com"; icon = "si:digitalocean"; same-tab = true; }
                          { title = "Hetzner DNS Console"; url = "https://www.hetzner.com/dns-console/"; icon = "si:hetzner"; same-tab = true; }
                        ];
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
