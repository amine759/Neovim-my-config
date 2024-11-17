local map = vim.keymap.set
local opts = { noremap = true, silent = true }
--based config
vim.opt.autoindent = true

vim.opt.smartindent = true
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"

map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Move lines up/down in Normal Mode
map("n", "<A-Down>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<A-j>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-k>", ":m .-2<CR>", { desc = "Move line up" })
-- Move lines up/down in Insert Mode
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
-- Move lines up/down in Visual Mode
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
-- Map Alt+Right Arrow to go to the end of the line
map("n", "<A-Right>", "$", { desc = "Go to end of line" })
map("n", "<A-Left>", "^", { desc = "Go to beginning of line" })
-- Togglers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>ih", "<cmd>ToggleInlayHints<CR>", { desc = "Toggle inlay hints" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })
-- Term
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Term escape terminal mode" })

map({ "n", "t" }, "<A-l>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Term toggle vertical split" })

map({ "n", "t" }, "<A-j>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Term toggle horizontal split" })

map({ "n", "t" }, "<A-t>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Term toggle floating" })

-- Tab and Shift-Tab for indenting and unindenting in Visual mode
map("v", "<Tab>", ">gv", { desc = "Indent right" })
map("v", "<S-Tab>", "<gv", { desc = "Indent left" })

-- LSP mappings for various functionalities
local function go_to_definition()
  local success, result = pcall(vim.lsp.buf.definition)
  if not success then
    print("No definition found!")
  end
end

local function show_hover()
  local success, result = pcall(vim.lsp.buf.hover)
  if not success then
    print("No hover information available!")
  end
end

local function show_signature_help()
  local success, result = pcall(vim.lsp.buf.signature_help)
  if not success then
    print("No signature help available!")
  end
end

local function find_references()
  local success, result = pcall(vim.lsp.buf.references)
  if not success then
    print("No references found!")
  end
end

local function rename_symbol()
  local success, result = pcall(vim.lsp.buf.rename)
  if not success then
    print("Renaming failed!")
  end
end

-- LSP mappings
map('n', 'gd', go_to_definition, { noremap = true, silent = true })
map('n', 'K', show_hover, { noremap = true, silent = true })
map('n', '<leader>s', show_signature_help, { noremap = true, silent = true })
map('n', '<leader>r', find_references, { noremap = true, silent = true })
map('n', '<leader>n', rename_symbol, { noremap = true, silent = true })


-- Scala-specific mappings for Metals
--map("n", "<Leader>a", function() require("metals").import_all() end, opts)
-- map("n", "<Leader>r", function() require("metals").import_remove_unused() end, opts)
-- Load nvchad mappings
require("nvchad.mappings")
