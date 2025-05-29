{ primary-user, ... }:
{
  jovian = {
    devices.steamdeck = {
      enable = true;
      autoUpdate = true;
    };
    steam = {
      enable = true;
      autoStart = true;
      desktopSession = "gnome";
      user = primary-user.name;
    };
  };
}
