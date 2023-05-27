{pkgs, ...}: {
  programs.nixneovim = {
    enable = true;
    extraLuaPreConfig = ''
      vim.g.gitblame_date_format = '%r'
      vim.g.gitblame_message_when_not_committed = '''

      vim.opt.list = true
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"
    '';
    extraPlugins = with pkgs.vimExtraPlugins; [dracula-vim git-blame-nvim];
    colorscheme = "dracula";
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
    mappings = {
      normal = {
        "<C-a>" = "'<cmd>bp<Return>'";
        "<C-d>" = "'<cmd>bn<Return>'";
        "<C-h>" = {
          silent = true;
          action = "'<cmd>noh<Return>'";
        };
        "<leader>w" = {
          silent = true;
          action = "'<cmd>bdelete<Return><cmd>bnext<Return>'";
        };
        "<leader>1" = {
          silent = true;
          action = "'<cmd>NvimTreeToggle<Return>'";
        };
        "<leader>`" = {
          silent = true;
          action = "'<cmd>split term://zsh<Return>'";
        };
        "<leader>ff" = {
          silent = true;
          action = "'<cmd>Telescope find_files<cr>'";
        };
        "<leader>fg" = {
          silent = true;
          action = "'<cmd>Telescope live_grep<cr>'";
        };
        "<leader>fb" = {
          silent = true;
          action = "'<cmd>Telescope buffers<cr>'";
        };
      };
    };
    plugins = {
      comment.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      indent-blankline = {
        enable = true;
        showEndOfLine = true;
      };
      telescope.enable = true;
      nvim-tree = {
        enable = true;
        diagnostics.enable = true;
        disableNetrw = true;
        git.enable = true;
      };
      bufferline = {
        enable = true;
        alwaysShowBufferline = true;
        diagnostics = "nvim_lsp";
        separatorStyle = "slant";
        offsets = [
          {
            filetype = "NvimTree";
            text = "File Explorer";
            separator = true;
          }
        ];
      };
      lualine = {
        enable = true;
        globalstatus = true;
      };
      nvim-cmp = {
        enable = true;
        snippet.luasnip.enable = true;
        sources = {
          buffer.enable = true;
          nvim_lsp.enable = true;
          nvim_lsp_document_symbol.enable = true;
          nvim_lsp_signature_help.enable = true;
          treesitter.enable = true;
          luasnip.enable = true;
        };
      };
      luasnip.enable = true;
      treesitter = {
        enable = true;
        installAllGrammars = true;
        indent = true;
        incrementalSelection.enable = true;
      };
      treesitter-context.enable = true;
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          nil.enable = true;
          rust-analyzer.enable = true;
        };
      };
    };
  };
}
