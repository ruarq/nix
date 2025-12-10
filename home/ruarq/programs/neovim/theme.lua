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
