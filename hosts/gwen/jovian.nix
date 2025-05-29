{ inputs, pkgs, primary-user, ... }:
{
  environment.systemPackages = with inputs.jovian.legacyPackages.${pkgs.system}; [
    galileo-mura
    jupiter-dock-updater-bin
    jupiter-hw-support
    steamdeck-bios-fwupd
  ];
  programs.steam = {
    enable = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };
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
