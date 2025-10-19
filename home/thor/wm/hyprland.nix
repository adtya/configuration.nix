_: {
  wayland.windowManager.hyprland = {
    settings = {
      experimental.xx_color_management_v4 = true;
      render.cm_auto_hdr = 1;

      monitorv2 = [
        {
          output = "DP-1";
          mode = "3440x1440@175";
          position = "0x0";
          scale = "auto";
          transform = 0;
          vrr = 2;
          supports_wide_color = 1;
          supports_hdr = 1;
          bitdepth = 10;
        }
      ];

      windowrulev2 = [
        "workspace 9,class:steam"

        "float,class:.virt-manager-wrapped"
        "size 25% 50%,class:.virt-manager-wrapped,title:Virtual Machine Manager"
        "move 5%% 10%,class:.virt-manager-wrapped,title:Virtual Machine Manager"

        "float,class:.piper-wrapped"
        "size 50% 50%,class:.piper-wrapped"
        "center,class:.piper-wrapped"

        "workspace 9,class:net.lutris.Lutris"
        "float,class:net.lutris.Lutris"
        "center,class:net.lutris.Lutris"
        "size 60% 60%,class:net.lutris.Lutris"
      ];
    };
  };
}
