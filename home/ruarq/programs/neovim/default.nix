{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-prettier

      {
        plugin = oil-nvim;
        type = "lua";
        config = ''
          require('oil').setup {}
        '';
      }

      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = ''
          require('colorizer').setup {}
        '';
      }

      # language server
      vim-nix
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          -- nixd
          require('lspconfig').nixd.setup {}

          -- typescript
          require('lspconfig').ts_ls.setup {}

          -- golang
          require('lspconfig').gopls.setup {
            cmd = { "${pkgs.gopls}/bin/gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            settings = {
              gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                  unusedParams = true,
                },
              },
            },
          }

          -- rust
          require('lspconfig').rust_analyzer.setup {
            cmd = { "${pkgs.rust-analyzer}/bin/rust-analyzer" },
            settings = {
              ['rust-analyzer'] = {
                checkOnSave = true,
                inlayHints = {
                  enable                      = true,
                  maxLength                   = null,
                  closureStyle                = "impl_fn",
                  closureReturnTypeHints      = { enable = "never" },
                  discriminantHints           = { enable = "always" },
                  bindingModeHints            = { enable = true },
                  chainingHints               = { enable = true },
                  closureCaptureHints         = { enable = true },
                  implicitDrops               = { enable = false },
                  implicitSizedBoundHints     = { enable = true },
                  parameterHints              = { enable = true },
                  rangeExclusiveHints         = { enable = true },
                  renderColons                = true,

                  closingBraceHints = {
                    enable = true,
                    minLines = 25,
                  },

                  expressionAdjustmentHints = {
                    enable = "never",
                    hideOutsideUnsafe = false,
                    mode = "prefix",
                  },

                  genericParameterHints = {
                    const     = { enable = true },
                    lifetime  = { enable = false },
                    type      = { enable = false },
                  },

                  lifetimeElisionHints = {
                    enable = "never",
                    useParameterNames = true,
                  },

                  typeHints = {
                    enable = true,
                    hideClosureInitialization = false,
                    hideClosureParameter = false,
                    hideNamedConstructor = false,
                  },
                },
              },
            },
          }
        '';
      }

      # fuzzy finder
      plenary-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup{}
        '';
      }

      # syntax-highlighting
      rust-vim
      {
        plugin = nvim-treesitter.withPlugins (plugins: [
          plugins.rust
          plugins.nix
          plugins.lua
          plugins.bash
          plugins.vim
        ]);
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            highlight = {
              enable = true,
            },
          }
        '';
      }

      # auto completion
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
        local cmp = require('cmp')

        cmp.setup{
          mapping = cmp.mapping.preset.insert({
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true, }),
            ['<C-e>'] = cmp.mapping.abort(),
          }),
          sources = cmp.config.sources(
            { 
              { name = 'nvim_lsp' },
            },
            {
              { name = 'buffer' },
              { name = 'path' },
            }
          )
        }
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      # theme
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
        require("catppuccin").setup {
          flavour = "mocha",
          background = {
            light = "latte",
            dark = "mocha",
          },
          transparent_background = false,
          term_colors = false,
          integrations = {
            cmp = true,
            nvimtree = true,
            treesitter = true,
            telescope = {
              enabled = true,
            },
          },
        }

        vim.cmd.colorscheme "catppuccin"
        '';
      }
    ];

    extraPackages = with pkgs; [
      nixd
      ripgrep
      fd
      rust-analyzer
      rustfmt
      gopls
      typescript-language-server
      prettierd
    ];

    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.swapfile = false
      vim.opt.hlsearch = true
      vim.opt.incsearch = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.updatetime = 50
      vim.opt.signcolumn = 'number'

      vim.g.mapleader = " "

      -- set prettier path to prettierd for faster formatting
      vim.g["prettier#exec_cmd_path"] = "${pkgs.prettierd}/bin/prettierd"

      -- to switch between buffers more easily
      vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>')
      vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>')

      -- oil keybindings
      vim.keymap.set('n', '<leader>o', '<cmd>Oil<CR>')

      -- telescope keybindings
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
      vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>')
      vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>')

      -- lsp keybindings
      vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)
      vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover)
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
      vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format {
          async = true,
        }
      end)

      -- diagnostic configuration
      vim.diagnostic.config {
        virtual_text = {
          prefix = '%',
        },
        severity_sort = true,
      }

      -- format on save rust files
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
        callback = function()
          vim.lsp.buf.format {
            async = false,
          }
        end,
      })

      -- format on save with prettier
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss,*.md,*.html",
        command = "Prettier",
      })

      -- inlay hints
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    '';
  };
}

