{ config, pkgs, ... }: {
  systemd.user.services.aria2c = {
    Unit = {
      Description = "Aria2c Download Manager";
      Documentation = [ "man:aria2c(1)" ];
      After = [ "network.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.aria}/bin/aria2c --console-log-level=warn --log-level=notice --enable-rpc --rpc-listen-all --rpc-listen-port=6800 --dir="${config.xdg.userDirs.download}"
      '';
    };
  };
}
