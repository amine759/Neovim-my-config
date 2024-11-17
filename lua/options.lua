require "nvchad.options"

vim.opt.number = true -- Show absolute line number for the current line
-- add yours here!
vim.opt.relativenumber = true -- Show relative line numbers
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
-- files reformatting

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.cmd "silent !stylua %"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.scala",
  callback = function()
    vim.cmd "silent !scalafmt %"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.cmd "silent !black %"
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.cmd "silent !gofmt -w %"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.yaml",
  callback = function()
    vim.cmd "silent !prettier --write %"
  end,
})
