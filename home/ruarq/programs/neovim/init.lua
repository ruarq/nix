require("gitblame").setup({
	enabled = false,
})

require("oil").setup({})
require("colorizer").setup({})
vim.lsp.enable("jdtls")

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = require("telescope.themes").get_ivy({
		file_ignore_patterns = {
			"%.git/",
		},

		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<Tab>"] = {
					actions.move_selection_next,
					type = "action",
					opts = { nowait = true, silent = true },
				},
				["<S-Tab>"] = {
					actions.move_selection_previous,
					type = "action",
					opts = { nowait = true, silent = true },
				},
			},
		},
	}),
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

require("catppuccin").setup({
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
})

vim.cmd.colorscheme("catppuccin")

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
vim.opt.signcolumn = "number"

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})

vim.api.nvim_create_user_command("Blame", "GitBlameToggle", {})
