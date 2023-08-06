{pkgs, ...}: {
  xdg.desktopEntries = {
    "nvim".name = "Neovim wrapper";
    "nvim".exec = "nvim %F";
    "nvim".noDisplay = true;
  };
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;
    colorscheme = "dracula";
    extraPlugins = with pkgs.vimPlugins; [
      dracula-vim
    ];
    options = {
      autowrite = true;
      background = "dark";
      clipboard = "unnamedplus";
      expandtab = true;
      laststatus = 2;
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
        "<C-a>" = {
          silent = true;
          action = "<cmd>bp<Return>";
        };
        "<C-d>" = {
          silent = true;
          action = "<cmd>bn<Return>";
        };
        "<C-h>" = {
          silent = true;
          action = "<cmd>noh<Return>";
        };
        "<leader>w" = {
          silent = true;
          action = "<cmd>bdelete<Return><cmd>bnext<Return>";
        };
        "<leader>1" = {
          silent = true;
          action = "<cmd>:Neotree toggle<Return>";
        };
      };
    };
    plugins = {
      bufferline = {
        enable = true;
        diagnostics = "nvim_lsp";
        offsets = [
          {
            filetype = "neo-tree";
            text = "File Explorer";
            separator = true;
          }
        ];
        separatorStyle = "slant";
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;
      gitsigns = {
        enable = true;
        currentLineBlame = true;
        currentLineBlameOpts.delay = 100;
      };
      indent-blankline = {
        enable = true;
        showEndOfLine = true;
        useTreesitter = true;
        useTreesitterScope = true;
      };
      intellitab = {
        enable = true;
      };
      lastplace = {
        enable = true;
      };
      neo-tree = {
        enable = true;
        addBlankLineAtTop = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        closeIfLastWindow = true;
        buffers = {
          followCurrentFile = true;
        };
        filesystem = {
          followCurrentFile = true;
          useLibuvFileWatcher = true;
        };
      };
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          gopls.enable = true;
          jsonls.enable = true;
          nixd.enable = true;
          rust-analyzer.enable = true;
          yamlls.enable = true;
        };
      };
      lualine = {
        enable = true;
        globalstatus = true;
        theme = "dracula";
      };
      nvim-cmp = {
        enable = true;
      };
      treesitter = {
        enable = true;
      };
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
    };
  };
}
