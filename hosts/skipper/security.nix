_:
{
  security = {
    pam = {
      services = {
        passwd.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
        hyprlock = { };
      };
    };
    rtkit.enable = true;
  };
}
