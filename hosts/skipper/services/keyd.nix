_: {
  services.keyd = {
    enable = true;
    keyboards = {
      builtin = {
        ids = [ "0001:0001" ];
        settings = {
          main = {
            pageup = "noop";
            pagedown = "noop";
            right = "noop";
            left = "noop";
            up = "noop";
            down = "noop";
          };
        };
      };
    };
  };
}
