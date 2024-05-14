_: {
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
        };
      };
    };
  };

}
