{ pkgs, ... }: {

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
