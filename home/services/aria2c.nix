{ config
, pkgs
, secrets
, ...
}: {
  systemd.user.services = {
    ariang = {
      Unit = {
        Description = "AriaNg: Web frontend for aria2c";
        After = [ "network.target" "aria2c.service" ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.merecat}/bin/merecat -n -p 6801 "${pkgs.ariang}/share/ariang"
        '';
      };
    };
    aria2c = {
      Unit = {
        Description = "Aria2c Download Manager";
        Documentation = [ "man:aria2c(1)" ];
        After = [ "network.target" ];
      };
      Install = {
        WantedBy = [ "default.target" "ariang.service" ];
      };
      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.aria}/bin/aria2c --console-log-level=warn --log-level=notice --enable-rpc --rpc-secret="${secrets.aria2_config.rpc_secret}" --rpc-listen-port=6800 --rpc-allow-origin-all --rpc-listen-all --dir="${config.xdg.userDirs.download}"
        '';
      };
    };
  };
}
