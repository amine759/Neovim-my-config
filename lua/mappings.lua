require "nvchad.mappings"

--based config
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4         -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4      -- Size of an indent
vim.opt.expandtab = true    -- Convert tabs to spaces

vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>h', '<C-s>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-s>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-s>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<C-s>l', { noremap = true, silent = true })


local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
