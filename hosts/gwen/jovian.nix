{ primary-user, ... }:
{
  jovian = {
    devices.steamdeck.enable = true;
    #hardware.has.amd.gpu = true;
    steam = {
      enable = true;
      autoStart = true;
      user = primary-user.name;
    };
  };
}
