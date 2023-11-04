{ pkgs, ... }: {
  services.udev = {
    enable = true;
    packages = [ pkgs.yubikey-personalization ];
  };
}
