{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ cosmic-files ];
  programs = {
    fd = {
      enable = true;
      ignores = [
        ".git/"
        "node_modules/"
      ];
    };
    yazi = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
          show_hidden = false;

        };
        preview = {
          image_filter = "lanczos3";
          image_quality = 90;
        };
        opener = {
          edit-text = [
            {
              run = ''${lib.getExe config.programs.neovim.package} "$0"'';
              block = true;
            }
          ];
          terminal = [
            {
              run = ''${lib.getExe config.programs.ghostty.package} --class=yazi --working-directory="$0"'';
              orphan = true;
            }
          ];
          open = [
            {
              run = ''${lib.getExe' pkgs.xdg-utils "xdg-open"} "$0"'';
              orphan = true;
            }
          ];
        };
        open.rules = [
          {
            mime = "text/*";
            use = [ "edit-text" ];
          }
          {
            mime = "application/json";
            use = [ "edit-text" ];
          }
          {
            mime = "inode/directory";
            use = [ "terminal" ];
          }
          {
            mime = "*";
            use = [ "open" ];
          }
          {
            name = "*";
            use = [ "open" ];
          }
        ];
      };
    };
  };

}
