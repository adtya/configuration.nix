_: {
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [ "DP-1,  preferred,  0x0,  auto" ];

      windowrulev2 = [
        "workspace 9,class:steam"

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
