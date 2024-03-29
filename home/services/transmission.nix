{ config, pkgs, ... }: {
  systemd.user.services = {
    transmission-daemon =
      let
        torrents-dir = "${config.xdg.userDirs.download}/Torrents";
        transmission-daemon = "${pkgs.transmission_4}/bin/transmission-daemon";
      in
      {
        Unit = {
          Description = "Transmission Daemon";
          Documentation = [ "man:transmission-daemon(1)" ];
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = ''
            ${transmission-daemon} -f --encryption-preferred --portmap --dht --lpd --utp --peerport 51414 --port 9092 \
              -c "${torrents-dir}/init" \
              --incomplete-dir "${torrents-dir}/.incomplete" \
              --download-dir "${torrents-dir}/downloads" \
          '';
        };
      };
  };
}
