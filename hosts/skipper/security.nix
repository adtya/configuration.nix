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
        settings = {
          authFile = "/persist/secrets/u2f/u2f_keys";
          cue = true;
        };
      };
    };
    polkit = {
      enable = true;
      adminIdentities = [ "unix-group:wheel" ];
    };
    rtkit.enable = true;
    sudo = {
      enable = true;
      package = pkgs.sudo.override { withInsults = true; };
      extraConfig = ''
        Defaults lecture="never"
      '';
      wheelNeedsPassword = true;
    };
  };
}
