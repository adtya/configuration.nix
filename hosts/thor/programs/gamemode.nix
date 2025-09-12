_: {
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        inhibit_screensaver = 1;
        softrealtime = "on";
      };
      cpu = {
        amd_x3d_mode_desired = "cache";
        amd_x3d_mode_default = "frequency";
      };
    };
  };
  nodeconfig.users.primary.extra-groups = [ "gamemode" ];
}
