vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Moves highlighted lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Moves highlighted lines up

vim.keymap.set("n", "J", "mzJ`z") -- Appends the line below to the current line, but keeps the cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Scrolls down a half-page, but keeps the cursor vertically centered
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Scrolls up a half-page, but keeps the cursor vertically centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP") -- Greatest remap ever

vim.keymap.set("n", "<leader>y", "\"+y") -- Yank into the system clipboard
vim.keymap.set("v", "<leader>y", "\"+y") -- Yank into the system clipboard
vim.keymap.set("n", "<leader>Y", "\"+Y") -- Yank into the system clipboard

vim.keymap.set("n", "Q", "<nop>") -- Saves you from accidentally closing the window

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Search and replace

vim.keymap.set("n", "<leader><leader>", function() -- Quickly source the current file with dbl. space
    vim.cmd("so")
end)

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])





