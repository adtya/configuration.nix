{ config, pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfigLuaPre = ''
      vim.g.gitblame_date_format = '%r'
      vim.g.gitblame_message_when_not_committed = '''
      
      vim.opt.list = true
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"
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
      splitright = true;
      splitbelow = true;
    };
    maps = {
      normal = {
        "<C-a>" = ":bp<Return>";
        "<C-d>" = ":bn<Return>";
        "<C-h>" = {
          silent = true;
          action = ":noh<Return>";
        };
        "<leader>1" = {
          silent = true;
          action = ":NvimTreeToggle<Return>";
        };
        "<leader>`" = {
          silent = true;
          action = ":split term://zsh<Return>";
        };
        "<leader>ff" = {
          silent = true;
          action = "<cmd>Telescope find_files<cr>";
        };
        "<leader>fg" = {
          silent = true;
          action = "<cmd>Telescope live_grep<cr>";
        };
        "<leader>fb" = {
          silent = true;
          action = "<cmd>Telescope buffers<cr>";
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [ dracula-nvim git-blame-nvim ];
    colorscheme = "dracula";
    plugins = {
      comment-nvim.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      trouble.enable = true;
      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        sources = [
          { name = "buffer"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_document_symbol"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "treesitter"; }
          { name = "luasnip"; }
        ];
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;
      luasnip.enable = true;
      bufferline = {
        enable = true;
        diagnostics = "nvim_lsp";
        offsets = [
          {
            filetype = "NvimTree";
            separator = true;
          }
        ];
        separatorStyle = "slant";
        truncateNames = true;
      };
      treesitter = {
        enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          dockerfile
          gitcommit
          gitignore
          git_rebase
          go
          markdown
          markdown_inline
          nix
          rust
          toml
          yaml
        ];
        indent = true;
        incrementalSelection.enable = true;
      };
      treesitter-context = {
        enable = true;
      };
      treesitter-refactor = {
        enable = true;
      };
      telescope = {
        enable = true;
        extensions = {
          fzy-native = {
            enable = true;
          };
        };
      };
      lualine = {
        enable = true;
        globalstatus = true;
      };
      indent-blankline = {
        enable = true;
        showEndOfLine = true;
      };
      nvim-tree = {
        enable = true;
        disableNetrw = true;
        filesystemWatchers.enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          rnix-lsp.enable = true;
          rust-analyzer.enable = true;
        };
      };
    };
  };
}
