_: {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = [
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              transform = "normal";
              mode = "1920x1080";
              position = "0,0";
              scale = 1.0;
            }

          ];
        };
      }
      {
        profile = {
          name = "docked_1";
          outputs = [
            {
              criteria = "eDP-1";
              transform = "normal";
              mode = "1920x1080";
              position = "0,216";
              scale = 1.25;
            }
            {
              criteria = "DP-1";
              transform = "normal";
              position = "1536,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "docked_2";
          outputs = [
            {
              criteria = "eDP-1";
              transform = "normal";
              mode = "1920x1080";
              position = "0,216";
              scale = 1.25;
            }
            {
              criteria = "DP-2";
              transform = "normal";
              position = "1536,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "docked_3";
          outputs = [
            {
              criteria = "eDP-1";
              transform = "normal";
              mode = "1920x1080";
              position = "0,216";
              scale = 1.25;
            }
            {
              criteria = "DP-3";
              transform = "normal";
              position = "1536,0";
            }
          ];
        };
      }
    ];
  };
}
