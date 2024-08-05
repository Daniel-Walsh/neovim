-- Setting options
-- See `:help vim.o`

local o = vim.opt
local w = vim.wo

o.hlsearch = false -- Set highlight on search
o.incsearch = true -- Enable incremental search
o.ignorecase = true -- Case insentitive searching
o.smartcase = true -- ... UNLESS /C or capital used in search

w.number = true -- Make line numbers on by default
w.relativenumber = true -- Enable relative line numbers by default
w.signcolumn = "yes" -- Keep signcolumn on by default

o.showmode = false -- Hide the mode in the command bar

o.mouse = "a" -- Enable mouse support

o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.

o.breakindent = true -- Enable break indent

o.updatetime = 250 -- Decreasing update time
o.timeout = true -- ...
o.timeoutlen = 300 -- ...

o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience

o.termguicolors = true -- Make the terminal use more colours

o.wrap = false -- Disable line-wrapping

o.scrolloff = 8 -- never show less than 8 lines above or below when vertically scrolling

o.colorcolumn = "80" -- Mark column 80 to show optimum line length

o.tabstop = 2 -- Set my tabstop width
o.softtabstop = 2 -- Set my soft tabstop width
o.shiftwidth = 2 -- Set my shift width
o.expandtab = true -- Set expand tab to true

o.smartindent = true

o.splitbelow = true -- Split new horizontal windows below the current one
o.splitright = true -- Split new vertical windows to the right of the current one
