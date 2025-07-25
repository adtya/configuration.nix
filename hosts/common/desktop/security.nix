_: {
  security = {
    pam = {
      services = {
        passwd.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
        cosmic-greeter.enableGnomeKeyring = true;
        hyprlock = { };
      };
    };
    rtkit.enable = true;
  };
}
