{pkgs, ...}: {
  xdg.desktopEntries =
    if pkgs.stdenv.isLinux
    then {
      "nvim".name = "Neovim wrapper";
      "nvim".exec = "nvim %F";
      "nvim".noDisplay = true;
    }
    else {};
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      fd
      ripgrep
      tree-sitter
      nil
      nodePackages.yaml-language-server
    ];
    plugins = with pkgs.vimExtraPlugins; [
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require('nvim-web-devicons').setup {
            default = true
          }
        '';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
          require('nvim-tree').setup {
            diagnostics = {
              enable = true
            }
          }
        '';
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup{
            options = {
              offsets = {
                {
                  filetype = "NvimTree",
                  text = "File Explorer",
                  separator = true
                }
              },
              diagnostics = "nvim_lsp",
              separator_style = "slant",
              truncate_names = true
            }
          }
        '';
      }
      {
        plugin = dracula-vim;
        type = "lua";
        config = ''
          vim.cmd[[colorscheme dracula]]
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup {
            options = {
              icons_enabled = true,
              theme = 'dracula',
              globalstatus = true
            }
          }
        '';
      }
      {
        plugin = git-blame-nvim;
        type = "lua";
        config = ''
          vim.g.gitblame_date_format = '%r'
          vim.g.gitblame_message_when_not_committed = '''
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require('gitsigns').setup()
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          vim.opt.list = true
          vim.opt.listchars:append "space:⋅"
          vim.opt.listchars:append "eol:↴"
          require("indent_blankline").setup {
            show_end_of_line = true
          }
        '';
      }
      {
        plugin = nvim-lastplace;
        type = "lua";
        config = ''
          require('nvim-lastplace').setup {}
        '';
      }
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require('toggleterm').setup{}
        '';
      }
      {plugin = plenary-nvim;}
      {plugin = telescope-nvim;}
      {
        plugin = nvim-treesitter-context;
        type = "lua";
        config = ''
          require('treesitter-context').setup {
            enable = true
          }
        '';
      }
      {plugin = nvim-treesitter-refactor;}
      {
        plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
          with plugins; [
            bash
            dockerfile
            gitattributes
            gitcommit
            gitignore
            git_config
            git_rebase
            go
            gomod
            gosum
            ini
            json
            markdown
            markdown_inline
            nix
            toml
            yaml
          ]);
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            auto_install = false,
            highlight = true,
            refactor = {
              highlight_definitions = {
                enable = true,
                clear_on_cursor_move = false
              }
            }
          }
        '';
      }
      {plugin = LuaSnip;}
      {plugin = cmp-luasnip;}
      {plugin = cmp-nvim-lsp;}
      {plugin = cmp-buffer;}
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require('cmp')
          cmp.setup ({
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
            }, {
              { name = 'buffer' },
            })
          })
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          require('lspconfig').bashls.setup{
            capabilities = capabilities
          }
          require('lspconfig').dockerls.setup{
            capabilities = capabilities
          }
          require('lspconfig').gopls.setup{
            capabilities = capabilities
          }
          require('lspconfig').jsonls.setup{
            capabilities = capabilities
          }
          require('lspconfig').marksman.setup{
            capabilities = capabilities
          }
          require('lspconfig').nil_ls.setup{
            capabilities = capabilities
          }
          require('lspconfig').rust_analyzer.setup{
            capabilities = capabilities
          }
          require('lspconfig').yamlls.setup {
            capabilities = capabilities,
            settings = {
              yaml = {
                schemas = {
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                  ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose.yml",
                  ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose.yaml"
                }
              }
            }
          }
        '';
      }
    ];
    extraConfig = ''
      set autowrite
      set background=dark
      set clipboard+=unnamedplus
      set expandtab
      set laststatus=2
      set noshowmode
      set noswapfile
      set number
      set relativenumber
      set shiftwidth=2
      set signcolumn=yes
      set smartindent
      set tabstop=2
      set termguicolors
      set updatetime=100
      set wrap
      set splitright
      set splitbelow

      nmap <C-a> <cmd>bp<Return>
      nmap <C-d> <cmd>bn<Return>
      nnoremap <C-h> <cmd>noh<Return>
      nnoremap <leader>w <cmd>bdelete<CR><cmd>bnext<Return>
      nnoremap <leader>` <cmd>ToggleTerm<Return>
      nnoremap <leader>1 <cmd>NvimTreeToggle<Return>
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
  };
}
