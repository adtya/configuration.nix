{ config, pkgs, ... }: {
  programs = {
    fd = {
      enable = true;
      ignores = [ ".git/" "node_modules/" ];
    };
    yazi = {
      enable = true;
      settings = {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
          show_hidden = true;

        };
        preview = {
          image_filter = "lanczos3";
          image_quality = 90;
        };
        opener = {
          edit-text = [
            { run = ''${config.programs.neovim.package}/bin/nvim "$0"''; block = true; }
          ];
          terminal = [
            { run = ''${config.programs.kitty.package}/bin/kitty --class=yazi -d="$0"''; orphan = true; }
          ];
          open = [
            { run = ''${pkgs.xdg-utils}/bin/xdg-open "$0"''; orphan = true; }
          ];
        };
        open.rules = [
          { mime = "text/*"; use = [ "edit-text" ]; }
          { mime = "application/json"; use = [ "edit-text" ]; }
          { mime = "inode/directory"; use = [ "terminal" ]; }
          { mime = "*"; use = [ "open" ]; }
          { name = "*"; use = [ "open" ]; }
        ];
      };
    };
  };

}
