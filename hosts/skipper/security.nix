{ pkgs, ... }: {
  security = {
    pam = {
      services = {
        passwd.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
        swaylock = { };
      };
      u2f = {
        enable = true;
        authFile = "/etc/u2f_keys";
        cue = true;
      };
    };
    polkit.enable = true;
    rtkit.enable = true;
    sudo = {
      package = pkgs.sudo.override { withInsults = true; };
      extraConfig = ''
        Defaults lecture="never"
      '';
      wheelNeedsPassword = true;
    };
  };
}
