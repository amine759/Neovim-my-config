require "nvchad.mappings"
local map = vim.keymap.set


--based config
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4         -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4      -- Size of an indent
vim.opt.expandtab = true    -- Convert tabs to spaces

vim.opt.clipboard = "unnamedplus"
map("n", "<leader>e", ":NvimTreeToggle<CR>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Open a terminal in a horizontal split with <leader>t
map('n', '<leader>t', ':split | terminal<CR>')
-- Open a terminal in a vertical split with <leader>vt
map('n', '<leader>vt', ':vsplit | terminal<CR>')
