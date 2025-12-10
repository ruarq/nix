vim.g.mapleader = " "

vim.g["prettier#exec_cmd_path"] = "prettierd"

vim.keymap.set('n', '<leader>m', '<cmd>Man<CR>')
vim.keymap.set('n', '<leader>x', '<cmd>x<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>')

vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>')

vim.keymap.set('n', '<leader>o', '<cmd>Oil<CR>')

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<CR>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>')

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
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
