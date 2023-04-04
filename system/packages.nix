{ pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      cantarell-fonts
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  hardware.gpgSmartcards.enable = true;
  programs = {
  dconf.enable = true;
    git.enable = true;
    gnupg.agent = {
      enable = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  seahorse.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };
  environment.pathsToLink = [ "/share/zsh" ];
}
