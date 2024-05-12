{ pkgs, helix, ... }: {
  programs.helix = {
    enable = true;
    package = helix.packages.${pkgs.system}.helix;
    settings = {
      theme = "dracula";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          select = "underline";
          normal = "block";
        };
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
      };
      language = [
        {
          name = "nix";
          file-types = [ "nix" ];
          roots = [ "flake.nix" ];
          language-servers = [ "nixd" ];
          formatter = {
            command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
          auto-format = true;
        }
      ];
    };
  };
}
