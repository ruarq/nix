{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # language server
      vim-nix
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
	        -- nixd
	        require('lspconfig').nixd.setup{}

	        -- rust
          require('lspconfig').rust_analyzer.setup {
            cmd = { "${pkgs.rust-analyzer}/bin/rust-analyzer" },
	          settings = {
	            ['rust-analyzer'] = {
	              checkOnSave = {
		              command = "clippy",
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
      lua-language-server
      nodePackages.bash-language-server
      ripgrep
      fd
      rust-analyzer
      rustfmt
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

      vim.g.mapleader = " "

      -- telescope keybindings
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')

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

      -- format on save rust files
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
	      callback = function()
          vim.lsp.buf.format {
            async = false,
          }
	      end
      })
    '';
  };
}
