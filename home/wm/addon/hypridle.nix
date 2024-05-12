{pkgs, ...}: {
  services.hypridle = {
    enable = true;
    settings = {
      lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
    };
  };
}
