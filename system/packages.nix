{pkgs, ...}: {
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      cantarell-fonts
      liberation_ttf
      (nerdfonts.override {fonts = ["FiraCode"];})
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  hardware.gpgSmartcards.enable = true;
  programs = {
    git.enable = true;
    gnupg.agent = {
      enable = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
      pinentryFlavor = "tty";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    xwayland.enable = true;
    zsh.enable = true;
  };
  environment.pathsToLink = ["/share/zsh"];
}
