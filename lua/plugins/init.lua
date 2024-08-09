return {
      {
            "stevearc/conform.nvim", -- when using .nvim opts is enough
            opts = {
                  formatters_by_ft = {
                        lua = { "stylua" },
                        python = { "black" },
                        yaml = { "prettier" },
                        go = { "goimports", "gofmt" },
                        sh = { "shfmt" },
            },
                },
          },
      {
            "neovim/nvim-lspconfig",
            config = function()
                require("nvchad.configs.lspconfig").defaults()
                require "configs.lspconfig"
                 end,
          },
      {
            "nvim-tree/nvim-tree.lua",
            requires = {
                  "nvim-tree/nvim-web-devicons", -- optional, for file icons
                },
            config = function()
                  require("nvim-tree").setup {}
            end,
          },
         {
            "nvim-treesitter/nvim-treesitter",
            opts = {
                  ensure_installed = {
                        "bash",
                        "html",
                        "javascript",
                        "json",
                        "lua",
                        "markdown",
                        "markdown_inline",
                        "python",
                        "regex",
                        "vim",
                        "yaml",
                        "go"
            },
            highlight = {
                            enable = true, -- false will disable the whole extension
            },
        }
                },
}
