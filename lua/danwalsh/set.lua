-- Changes the cursor to always be phatt
-- vim.opt.guicursor = ""

vim.opt.nu = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers

vim.opt.tabstop = 2 -- Set my tabstop width
vim.opt.softtabstop = 2 -- Set my soft tabstop width
vim.opt.shiftwidth = 2 -- Set my shift width
vim.opt.expandtab = true -- Set expand tab to true

vim.opt.smartindent = true

vim.opt.wrap = false -- Disable line wrapping

vim.opt.swapfile = false -- Disable nvim swapfile (for undo history)
vim.opt.backup = false -- Disable nvim backup (for undo history)
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set the dir for undofile
vim.opt.undofile = true -- Tell undofile to manage all my undo history

vim.opt.hlsearch = false -- Disable highlight search
vim.opt.incsearch = true -- Enable incremental search

vim.opt.termguicolors = true

vim.opt.scrolloff = 8 -- Never show less than 8 lines above or below when vertically scrolling
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50 -- Set a fast update time

vim.opt.colorcolumn = "80" -- Mark column 80 to show optimum line length

vim.g.mapleader = " "
