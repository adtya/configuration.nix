{ config, pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfigLuaPre = ''
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.g.gitblame_date_format = '%r'
      vim.g.gitblame_message_when_not_committed = '''
    '';
    options = {
      autowrite = true;
      background = "dark";
      clipboard = "unnamedplus";
      expandtab = true;
      laststatus = 2;
      list = true;
      showmode = false;
      swapfile = false;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      signcolumn = "yes";
      smartindent = true;
      tabstop = 2;
      termguicolors = true;
      updatetime = 100;
      wrap = true;
    };
    extraPlugins = with pkgs.vimPlugins; [ dracula-nvim git-blame-nvim ];
    colorscheme = "dracula";
    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash dockerfile gitcommit gitignore git_rebase go markdown markdown_inline nix rust toml yaml
        ];
        folding = true;
        indent = true;
        incrementalSelection.enable = true;
      };
      treesitter-context = {
        enable = true;
      };
      treesitter-refactor = {
        enable = true;
        highlightCurrentScope.enable = true;
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
            fuzzy = true;
          };
        };
      };
      fugitive.enable = true;
      lualine = {
        enable = true;
        globalstatus = true;
      };
    };
  };
}
