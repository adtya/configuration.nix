_: {
  services.conky = {
    enable = true;
    extraConfig = builtins.readFile ./conky.conf;
  };
}
