-- Load defaults (e.g., lua_lsp)
local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local metals = require("metals")

-- List of LSP servers
local servers = {
  "bashls",
  "cssls",
  "html",
  "clangd",
  "hls",
  "gopls",
  "jsonls",
  "pyright",
  "somesass_ls",
}

-- Lazy-load LSP servers using an autocmd
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("LazyLSP", { clear = true }),
  callback = function()
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end
  end,
})

-- Lua LSP specific setup
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      hint = { enable = true },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim", "bit", "it", "describe", "before_each", "after_each" },
      },
    },
  },
}

-- Metals (Scala) LSP setup
local metals_config = metals.bare_config()

metals_config.on_attach = on_attach
metals_config.capabilities = capabilities

-- Scala-specific Autocmd for Metals
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
})
