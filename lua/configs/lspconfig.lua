-- load defaults i.e lua_lsp
local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

local servers = {
  "bashls",
  "cssls",
  "html",
  "jsonls",
  "pyright",
  "somesass_ls",
  "ts_ls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
  settings = {
    Lua = {
      hint = { enable = true },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
      },
    },
  },
}
