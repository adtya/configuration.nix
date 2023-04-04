{ pkgs, ... }: {
  xdg.dataFile."wallpapers/catppuccin".source = "${pkgs.catppuccin-wallpapers}/share/wallpapers";
}
