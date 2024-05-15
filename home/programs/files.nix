{ config, ... }: {
  programs = {
    fd = {
      enable = true;
      ignores = [ ".git/" "node_modules/" ];
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
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
          open-image = [
            { run = "${config.programs.imv.package}/bin/imv-dir $0"; orphan = true; }
          ];
          edit-text = [
            { run = "${config.programs.neovim.package}/bin/nvim $0"; block = true; }
          ];
          play = [
            { run = "${config.programs.mpv.package}/bin/mpv $0"; orphan = true; }
          ];
          terminal = [
            { run = "${config.programs.kitty.package}/bin/kitty --class=yazi -d=$0"; orphan = true; }
          ];
        };
        open.rules = [
          { mime = "image/*"; use = "open-image"; }
          { mime = "text/*"; use = [ "edit-text" ]; }
          { mime = "video/*"; use = [ "play" ]; }
          { mime = "inode/directory"; use = [ "terminal" ]; }
        ];
      };
    };
  };

}
