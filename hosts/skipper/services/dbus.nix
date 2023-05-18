{pkgs, ...}: {
  services.dbus = {
    enable = true;
    apparmor = "enabled";
    packages = with pkgs; [gcr gcr_4];
  };
}
