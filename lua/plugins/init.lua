return {
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        yaml = { "prettier" },
        go = { "goimports", "gofmt" },
        sh = { "shfmt" },
        scala = { "scalafmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
      },
    },
  },
  {
    "git@github.com:github/copilot.vim.git", -- ✅ Correct repo
    ft = { "lua", "python" },                 -- ✅ Load only for Lua and Python
    lazy = true,
    config = function()
      vim.cmd [[
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
      ]]
    end,
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
    dependencies = {
      "nvim-tree/nvim-web-devicons",
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
        "go",
        "yamllint",
      },
      highlight = { enable = true },
    },
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  { import = "plugins.dap-python" },
  { import = "plugins.dap-js" },
}

