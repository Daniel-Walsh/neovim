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
end, { desc = "Toggle relative [l]ine [n]umbers" })

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

set("n", "<leader><Esc>", vim.cmd.Ex, { desc = "[Esc]ape the current buffer and return to Netrw Explorer" })

set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves highlighted lines down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves highlighted lines up" })

set("n", "J", "mzJ`z", { desc = "Appends the line below to the current line, but keeps the cursor in place" })

-- Scrolling
set("n", "<C-d>", "<C-d>zz", { desc = "Scrolls down a half-page, but keeps the cursor vertically centered" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scrolls up a half-page, but keeps the cursor vertically centered" })

set("n", "n", "nzzzv", { desc = "Scroll to the next search term, but keep the cursor vertically centered." })
set("n", "N", "Nzzzv", { desc = "Scroll to the previous search term, but keep the cursor vertically centered." })

-- Clipboard
set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to the system clipboard" })
set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank to the system clipboard" })

-- Macros
set("n", "Q", "@qj", { desc = "Executes the macro stored in the 'q' register and jumps down to the next line" })
set("x", "Q", ":norm @q<CR>", { desc = "Executes the macro stored in the 'q' register for every line in visual mode" })

set("n", "[c", vim.cmd.cp, { desc = "Go to the previous Qui[c]kfix error", silent = true })
set("n", "]c", vim.cmd.cn, { desc = "Go to the next Qui[c]kfix error", silent = true })

set("t", "<Esc>", [[<C-\><C-n>]], { desc = "[Esc]apes from terminal mode" })

set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessioniser<CR>",
  { desc = "[F]ind and open another project folder in Neovim" })

set("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat the current buffer using LSP" })

-- set("n", "<C-h>", "<C-w>h", { desc = "Switch focus to the split buffer LEFT of the current buffer." })
-- set("n", "<C-j>", "<C-w>j", { desc = "Switch focus to the split buffer BELOW the current buffer." })
-- set("n", "<C-k>", "<C-w>k", { desc = "Switch focus to the split buffer ABOVE the current buffer." })
-- set("n", "<C-l>", "<C-w>l", { desc = "Switch focus to the split buffer RIGHT of the current buffer." })
