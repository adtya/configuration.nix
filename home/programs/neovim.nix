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
    colorschemes.dracula = {
      enable = true;
      fullSpecialAttrsSupport = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      git-blame-nvim
    ];
    extraPackages = with pkgs; [
      fd
      ripgrep
    ];
    extraConfigLuaPre = ''
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"
    '';
    globals = {
      gitblame_date_format = "%r";
    };
    options = {
      autowrite = true;
      background = "dark";
      clipboard = "unnamedplus";
      expandtab = true;
      laststatus = 2;
      list = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      showmode = false;
      signcolumn = "yes";
      smartindent = true;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      tabstop = 2;
      termguicolors = true;
      updatetime = 100;
      wrap = true;
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
        "<leader>`" = {
          silent = true;
          action = "<cmd>:ToggleTerm<Return>";
        };
        "<leader>1" = {
          silent = true;
          action = "<cmd>:Neotree toggle<Return>";
        };
        "<leader>ff" = {
          silent = true;
          action = "<cmd>:Telescope find_files<Return>";
        };
        "<leader>fg" = {
          silent = true;
          action = "<cmd>:Telescope live_grep<Return>";
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
      gitsigns.enable = true;
      indent-blankline = {
        enable = true;
        showEndOfLine = true;
        useTreesitter = true;
        useTreesitterScope = true;
      };
      lastplace.enable = true;
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
      neo-tree = {
        enable = true;
        addBlankLineAtTop = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        closeIfLastWindow = false;
        filesystem = {
          followCurrentFile = {
            enabled = true;
            leaveDirsOpen = false;
          };
          filteredItems.visible = true;
          useLibuvFileWatcher = true;
        };
      };
      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "buffers";}
          {name = "treesitter";}
        ];
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
            caseMode = "smart_case";
            fuzzy = true;
          };
        };
      };
      toggleterm = {
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
