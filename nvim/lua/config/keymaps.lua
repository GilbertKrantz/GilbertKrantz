-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- move lines up and down
vim.keymap.set("n", "<Down>", ":m .+1<CR>==")
vim.keymap.set("v", "<Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<Up>", ":m .-2<CR>==")
