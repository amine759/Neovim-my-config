return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  ft = { "rust" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local configs = require("nvchad.configs.lspconfig")
    vim.g.rustaceanvim = {
      -- LSP configuration
      server = {
        on_attach = configs.on_attach,  -- Use NvChad's on_attach
        on_init = configs.on_init,      -- Use NvChad's on_init
        capabilities = configs.capabilities,  -- Use NvChad's capabilities
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              allFeatures = true,
            },
          },
        },
      },
      -- DAP configuration
      dap = {
        adapter = {
          type = "executable",
          command = "lldb-vscode", -- or 'codelldb' if you install via Mason
          name = "rt_lldb",
        },
      },
    }
  end,
}
