-- Set custom keymaps
-- See `:help vim.keymap.set()`

local w = vim.wo
local g = vim.g
local set = vim.keymap.set
g.mapleader = " "
g.maplocalleader = " "

-- Map <leader>ln to toggle_hybrid_line_numbers function
set("n", "<leader>ln", function()
  w.relativenumber = not w.relativenumber
end)

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader><Esc>", vim.cmd.Ex, { desc = "[Esc]ape the current buffer and return to Netrw Explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves highlighted lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves highlighted lines up" })

vim.keymap.set( "n", "J", "mzJ`z", { desc = "Appends the line below to the current line, but keeps the cursor in place" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scrolls down a half-page, but keeps the cursor vertically centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scrolls up a half-page, but keeps the cursor vertically centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Scroll to the next term, but keep the cursor vertically centered." })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Scroll to the previous term, but keep the cursor vertically centered." })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to the system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank to the system clipboard" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Saves you from accidentally closing the window" })

vim.keymap.set("n", "[c", vim.cmd.cp, { desc = "Go to the previous Qui[c]kfix error", silent = true })
vim.keymap.set("n", "]c", vim.cmd.cn, { desc = "Go to the next Qui[c]kfix error", silent = true })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "[Esc]apes from terminal mode"})

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessioniser<CR>", { desc = "[F]ind and open another project folder in Neovim"})

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format the current buffer using LSP" })

-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch focus to the split buffer LEFT of the current buffer." })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch focus to the split buffer BELOW the current buffer." })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch focus to the split buffer ABOVE the current buffer." })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch focus to the split buffer RIGHT of the current buffer." })

