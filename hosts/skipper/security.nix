{ pkgs, ... }: {
  imports = [ ../shared/certs ];
  security = {
    pam = {
      services = {
        passwd.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
        hyprlock = { };
      };
      u2f = {
        enable = true;
        settings = {
          authFile = "/persist/secrets/u2f/u2f_keys";
          cue = true;
        };
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
