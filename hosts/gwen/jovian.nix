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
      desktopSession = "plasma";
      user = primary-user.name;
    };
  };
}
