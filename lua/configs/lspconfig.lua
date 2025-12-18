-- NvChad LSP defaults
local nvlsp = require("nvchad.configs.lspconfig")

local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities
local lsp = vim.lsp

-- Servers with default config
local servers = {
  "bashls",
  "cssls",
  "html",
  "jsonls",
  "pyright",
  "ts_ls",
  "rust_analyzer",
}


for _, server in ipairs(servers) do
  lsp.config[server] = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }

  lsp.enable(server)
end

-- Lua LSP (special case)
lsp.config.lua_ls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      hint = { enable = true },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim", "describe", "before_each", "after_each" },
      },
    },
  },
}

lsp.enable("lua_ls")
