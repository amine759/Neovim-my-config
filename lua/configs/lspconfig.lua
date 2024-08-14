-- load defaults i.e lua_lsp
local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local metals = require "metals"


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
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Lua LSP specific setup
 lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = on_init,
      settings = {
        Lua = {
          hint = { enable = true },
          telemetry = { enable = false },
          diagnostics = { globals = { "bit", "vim", "it", "describe", "before_each", "after_each" } },
        },
      },
    }

-- Metals (Scala) LSP setup
local metals_config = metals.bare_config()

metals_config.on_attach = function(client, bufnr)
  -- Use the same on_attach as other LSP servers
  on_attach(client, bufnr)
end

metals_config.capabilities = capabilities

-- Autocmd to initialize or attach Metals when opening a Scala file
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
