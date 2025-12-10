vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({
			async = false,
		})
	end,
})

vim.api.nvim_create_user_command("StyLua", "%!stylua -", { desc = "Format the current buffer using stylua" })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua",
	command = "StyLua",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss,*.md,*.html",
	command = "Prettier",
})
