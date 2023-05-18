{pkgs, ...}: {
  security = {
    apparmor = {
      enable = true;
      enableCache = true;
    };
    audit.enable = true;
    auditd.enable = true;
    pam = {
      services = {
        passwd.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
        swaylock = {};
      };
      u2f = {
        enable = true;
        authFile = "/etc/u2f_keys";
        cue = true;
      };
    };
    polkit.enable = true;
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      abrmd.enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
    sudo = {
      package = pkgs.sudo.override {withInsults = true;};
      extraConfig = ''
        Defaults lecture="never"
      '';
      wheelNeedsPassword = true;
    };
  };
}
