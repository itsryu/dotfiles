vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "e", ":NvimTreeToggle<CR>")
map("n", "w", ":w<CR>")
map("n", "q", ":q<CR>")

