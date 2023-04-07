{ ... }: {
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080";
            position = "0,0";
          }
        ];
      };
      docked_1 = {
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
            mode = "1920x1080";
            position = "1536,0";
          }
        ];
      };
      docked_2 = {
        outputs = [
          {
            criteria = "eDP-2";
            transform = "normal";
            mode = "1920x1080";
            position = "0,216";
            scale = 1.25;
          }
          {
            criteria = "DP-1";
            transform = "normal";
            mode = "1920x1080";
            position = "1536,0";
          }
        ];
      };
    };
  };
}
