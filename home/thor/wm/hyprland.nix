_: {
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [ "DP-1,  preferred,  0x0,  auto" ];

      windowrulev2 = [
        "float,class:.virt-manager-wrapped"
        "size 25% 50%,class:.virt-manager-wrapped,title:Virtual Machine Manager"
        "move 5%% 10%,class:.virt-manager-wrapped,title:Virtual Machine Manager"

        "float,class:.piper-wrapped"
        "size 50% 50%,class:.piper-wrapped"
        "center,class:.piper-wrapped"
      ];
    };
  };
}
