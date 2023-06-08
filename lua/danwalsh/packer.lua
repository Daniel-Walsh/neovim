-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'prichrd/netrw.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- use({
  --   'folke/tokyonight.nvim',
  --   config = function()
  --     require("tokyonight").setup({
  --       transparent = true
  --     })
  --     vim.cmd [[colorscheme tokyonight]]
  --   end
  -- })

  use { "catppuccin/nvim", as = "catppuccin" }


  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'MunifTanjim/prettier.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }

  use('nvim-tree/nvim-web-devicons')

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use('lewis6991/gitsigns.nvim')

  -- use {
  --   'numToStr/Comment.nvim',
  --   config = function()
  --     require('Comment').setup()
  --   end
  -- }

  use { "akinsho/toggleterm.nvim", tag = '*' }
  use "terrortylor/nvim-comment"

  use 'preservim/vim-markdown'
  use 'godlygeek/tabular'
  use 'epwalsh/obsidian.nvim'

  use('christoomey/vim-tmux-navigator', { lazy = false })
  -- use {
  --   'nvim-tree/nvim-tree.lua',
  --   requires = {
  --     'nvim-tree/nvim-web-devicons', -- optional
  --   },
  --   config = function()
  --     require("nvim-tree").setup {}
  --   end
  -- }


  use {
    "nvim-neorg/neorg",
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {},      -- Loads default behaviour
          -- ["core.concealer"] = {},       -- Adds pretty icons to your documents
          ["core.ui"] = {},            -- Adds pretty icons to your documents
          ["core.qol.toc"] = {},       -- Adds pretty icons to your documents
          ["core.esupports.hop"] = {}, -- Adds pretty icons to your documents
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                -- -- Unmaps any Neorg key from the `norg` mode
                -- keybinds.unmap("norg", "n", "gtd")

                -- -- Binds the `gtd` key in `norg` mode to execute `:echo 'Hello'`
                -- keybinds.map("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")

                -- -- Remap unbinds the current key then rebinds it to have a different action
                -- -- associated with it.
                -- -- The following is the equivalent of the `unmap` and `map` calls you saw above:
                -- keybinds.remap("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")

                -- -- Sometimes you may simply want to rebind the Neorg action something is bound to
                -- -- versus remapping the entire keybind. This remap is essentially the same as if you
                -- -- did `keybinds.remap("norg", "n", "<C-Space>, "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>")
                -- keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_done")

                -- -- Want to move one keybind into the other? `remap_key` moves the data of the
                -- -- first keybind to the second keybind, then unbinds the first keybind.
                keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>t")
              end,
            }
          },                            -- Adds pretty icons to your documents
          ["core.qol.todo_items"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {           -- Manages Neorg workspaces
            config = {
              workspaces = {
                work = "~/Notes/Work",
                personal = "~/Notes/Personal",
              },
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.integrations.treesitter"] = {},
        },
      }
    end,
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  }
end)
