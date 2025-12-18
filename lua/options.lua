require "nvchad.options"

vim.opt.number = true -- Show absolute line number for the current line
-- add yours here!
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true -- Show relative line numbers
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.clipboard = "unnamedplus"

vim.opt.encoding = "utf-8"


vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true

--search 
vim.opt.ignorecase = true
vim.opt.smartcase = true


vim.opt.updatetime = 50

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.py",
  callback = function()
    vim.opt.colorcolumn = ""
  end
})


vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.js", "*.html", "*.css", "*.lua"},
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end
})


-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end
})

-- After saving .py, runs ruff to sort imports and format.

local RuffSort = vim.api.nvim_create_augroup("RuffSort", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
  group = RuffSort,
  pattern = "*.py",
  callback = function()
    vim.cmd("silent !ruff check --select I --fix %")
    vim.cmd("silent !ruff format %")
  end,
})

-- json Folds 

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.json",
  callback = function()
    vim.opt_local.foldmethod = "syntax"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
  end
})
