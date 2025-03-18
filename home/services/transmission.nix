{ config, pkgs, ... }:
{
  systemd.user.services = {
    transmission-daemon =
      let
        torrents-dir = "${config.xdg.userDirs.download}/Torrents";
        incomplete-dir = "${config.xdg.userDirs.download}/.incomplete-torrents";
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
          Type = "notify";
          ExecStart = ''
            ${transmission-daemon} -f --log-level=error --encryption-preferred --portmap --dht --lpd --utp --peerport 41414 --port 9092 \
              --allowed 127.0.0.1,100.69.69.* \
              --incomplete-dir "${incomplete-dir}" \
              --download-dir "${torrents-dir}" \
          '';
          ExecStop = "kill -s STOP $MAINPID";
          ExecReload = "kill -s HUP $MAINPID";
        };
      };
  };
}
