local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    yaml = { "prettier" },
    go = { "goimports", "gofmt" },
    sh = { "shfmt" },
    scala = { "scalafmt" },
  },
  -- Enable format on save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
