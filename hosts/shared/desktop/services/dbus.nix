{ pkgs, ... }:
{
  services.dbus = {
    enable = true;
    packages = with pkgs; [
      gcr
      gcr_4
    ];
    implementation = "broker";
  };
}
