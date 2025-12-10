local lspconfig = require('lspconfig')

lspconfig.pyright.setup {}
lspconfig.tinymist.setup {}
lspconfig.ts_ls.setup {}
lspconfig.clangd.setup {}
lspconfig.lua_ls.setup {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },

      diagnostics = {
        globals = {
          "vim",
        },
      },

      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.nixd.setup {
  settings = {
    nixd = {
      formatting = {
        cmd = { "nixfmt" },
      },
    },
  },
}

lspconfig.gopls.setup {
  cmd = { "gopls" },
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

lspconfig.rust_analyzer.setup {
  cmd = { "rust-analyzer" },
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      inlayHints = {
        enable                      = true,
        maxLength                   = "null",
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
          lifetime  = { enable = true },
          type      = { enable = true },
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
