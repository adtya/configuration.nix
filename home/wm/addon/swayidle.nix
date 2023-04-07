{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -i /tmp/lockpaper.jpg";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.swaylock}/bin/swaylock -f -i /tmp/lockpaper.jpg";
      }
    ];
  };
}
