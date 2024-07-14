{ pkgs, ... }: {
  security = {
    pam = {
      services = {
        passwd.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
        hyprlock = { };
      };
      u2f = {
        enable = true;
        authFile = "/persist/secrets/u2f/u2f_keys";
        cue = true;
      };
    };
    pki.certificateFiles = [ ../shared/certs/local.adtya.xyz.CA.pem ];
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
