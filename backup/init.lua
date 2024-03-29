--[[
Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- Detect tabstop and shiftwidth automatically
  -- "tpope/vim-sleuth",

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim",       opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  -- {
  --   "creativenull/efmls-configs-nvim",
  --   version = "v1.x.x", -- version is optional, but recommended
  --   dependencies = { "neovim/nvim-lspconfig" },
  -- },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
  },

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim",          opts = {} },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          vim.keymap.set(
            "n",
            "<leader>gp",
            require("gitsigns").prev_hunk,
            { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
          )
          vim.keymap.set(
            "n",
            "<leader>gn",
            require("gitsigns").next_hunk,
            { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
          )
          vim.keymap.set(
            "n",
            "<leader>ph",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "[P]review [H]unk" }
          )
        end,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = true,
        },
        current_line_blame_formatter = "     <author> • <author_time> • <summary>",
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
    -- opts = {
    --   -- See `:help gitsigns.txt`
    --   signs = {
    --     add = { text = '+' },
    --     change = { text = '~' },
    --     delete = { text = '_' },
    --     topdelete = { text = '‾' },
    --     changedelete = { text = '~' },
    --   },
    --   on_attach = function(bufnr)
    --     vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
    --       { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
    --     vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
    --     vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
    --   end,
    -- },
  },

  {
    -- Theme inspired by Atom
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {},
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        style = "storm",
        styles = {
          functions = {}, -- disable italic for functions
        },
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    -- See `:help lualine.txt`
    config = function()
      local toykocolours = require("tokyonight.colors").setup({ style = "storm" })
      require("lualine").setup({
        options = {
          icons_enabled = true,
          -- theme = 'onedark',
          theme = "tokyonight",
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "branch",
              icon = "󰘬",
            },
            {
              "diff",
              -- colored = true, -- Displays a colored diff status if set to true
              diff_color = {
                --   -- Same color values as the general color option can be used here.
                added = { fg = toykocolours.green2 }, -- Changes the diff's added color
                modified = { fg = toykocolours.yellow }, -- Changes the diff's modified color
                removed = { fg = toykocolours.red }, -- changes the diff's removed color you
              },
              symbols = { added = " ", modified = " ", removed = " " },
              -- source = nil,                                             -- A function that works as a data source for diff.
              -- It must return a table as such:
              --   { added = add_count, modified = modified_count, removed = removed_count }
              -- or nil on failure. count <= 0 won't be displayed.
            },
            -- {
            --   'diagnostics',
            --   sources = { 'nvim_diagnostic' },
            --   symbols = { error = ' ', warn = ' ', info = ' ' },
            --   diagnostics_color = {
            --     color_error = { fg = toykocolors.red, gui = "bold" },
            --     color_warn = { fg = toykocolors.yellow, gui = "bold" },
            --     color_info = { fg = toykocolors.cyan, gui = "bold" },
            --   },
            -- }
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            {
              -- Lsp server name .
              function()
                local msg = "No Active Lsp"
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return msg
                end
                local lsp_names = {}
                local found_lsp = false
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    table.insert(lsp_names, client.name)
                    found_lsp = true
                  end
                end
                if found_lsp then
                  return table.concat(lsp_names, ", ")
                end
                return msg
              end,
              icon = "lsp://",
              separator = { left = "" },
            },
            -- 'progress'
          },
          lualine_z = {
            {
              "location",
              separator = { left = "" },
            },
          },
          -- lualine_a = { 'mode' },
          -- lualine_b = { 'branch', 'diff', 'diagnostics' },
          -- lualine_c = { 'filename' },
          -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
          -- lualine_y = { 'progress' },
          -- lualine_z = { 'location' }
        },
      })
    end,
    -- opts = {
    --   options = {
    --     icons_enabled = true,
    --     -- theme = 'onedark',
    --     theme = 'tokyonight',
    --     component_separators = '|',
    --     section_separators = '',
    --   },
    --   sections = {
    --     lualine_a = { 'mode' },
    --     lualine_b = {
    --       {
    --         'branch',
    --         icon = ''
    --       },
    --       {
    --         'diff',
    --         colored = true, -- Displays a colored diff status if set to true
    --         -- diff_color = {
    --         --   -- Same color values as the general color option can be used here.
    --         --   added    = 'LuaLineDiffAdd',                            -- Changes the diff's added color
    --         --   modified = 'LuaLineDiffChange',                         -- Changes the diff's modified color
    --         --   removed  = 'LuaLineDiffDelete',                         -- Changes the diff's removed color you
    --         -- },
    --         symbols = { added = ' ', modified = '󰣕 ', removed = '󰍷 ' }, -- Changes the symbols used by the diff.
    --         -- source = nil,                                             -- A function that works as a data source for diff.
    --         -- It must return a table as such:
    --         --   { added = add_count, modified = modified_count, removed = removed_count }
    --         -- or nil on failure. count <= 0 won't be displayed.
    --       },
    --       {
    --         'diagnostics',
    --         sources = { 'nvim_diagnostic' },
    --         symbols = { error = ' ', warn = ' ', info = ' ' },
    --         diagnostics_color = {
    --           color_error = { fg = colors.red },
    --           color_warn = { fg = colors.yellow },
    --           color_info = { fg = colors.cyan },
    --         },
    --       }
    --     },
    --     lualine_c = {},
    --     lualine_x = { 'encoding', 'fileformat', 'filetype' },
    --     lualine_y = {},
    --     lualine_z = {}
    --     -- lualine_a = { 'mode' },
    --     -- lualine_b = { 'branch', 'diff', 'diagnostics' },
    --     -- lualine_c = { 'filename' },
    --     -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
    --     -- lualine_y = { 'progress' },
    --     -- lualine_z = { 'location' }
    --   },
    -- },
  },

  -- {
  -- 	"mhartington/formatter.nvim",
  -- 	config = function()
  -- 		require("formatter").setup({
  -- 			filetype = {
  -- 				javascriptreact = {
  -- 					require("formatter.filetypes.javascriptreact").prettierd,
  -- 				},
  -- 				typescriptreact = {
  -- 					require("formatter.filetypes.typescriptreact").prettierd,
  -- 				},
  -- 				vue = {
  -- 					require("formatter.filetypes.vue").prettier,
  -- 				},
  -- 				javascript = {
  -- 					require("formatter.filetypes.javascript").prettierd,
  -- 				},
  -- 				typescript = {
  -- 					require("formatter.filetypes.typescript").prettierd,
  -- 				},
  -- 				lua = {
  -- 					require("formatter.filetypes.lua").stylua,
  -- 				},
  -- 				["*"] = {
  -- 					require("formatter.filetypes.any").remove_trailing_whitespace,
  -- 				},
  -- 			},
  -- 		})
  -- 		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  -- 			command = "FormatWriteLock",
  -- 		})
  -- 	end,
  -- },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = "┊",
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim",         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  -- UndoTree
  "mbbill/undotree",

  -- Harpoon
  "theprimeagen/harpoon",

  "nvim-tree/nvim-web-devicons",

  {
    "epwalsh/obsidian.nvim",
    lazy = false,
    event = {
      "BufReadPre /Users/danwalsh/Obsidian/**.md",
    },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      dir = "/Users/danwalsh/Obsidian", -- no need to call 'vim.fn.expand' here

      -- see below for full list of options 👇
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Notes/Daily",
        -- Optional, if you want to change the date format for daily notes.
        -- date_format = "%Y/%m/%Y-%m-%d"
        date_format = "%Y-%m-%d",
      },
      mappings = {
        -- ["gf"] = require("obsidian.mapping").gf_passthrough(),
      },
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },

  "b0o/incline.nvim",

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        -- markdown = {'vale',}
        javascript = { "eslint" },
        typescript = { "eslint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- {
  --   'akinsho/bufferline.nvim',
  --   version = "*",
  --   dependencies = 'nvim-tree/nvim-web-devicons',
  --   config = function()
  --     require("bufferline").setup()
  --   end
  -- },

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --   }
  -- },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- Flash.nvim
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     {
  --       "s",
  --       mode = { "n", "x", "o" },
  --       function()
  --         require("flash").jump({
  --           search = {
  --             mode = function(str)
  --               return "\\<" .. str
  --             end,
  --           },
  --         })
  --       end,
  --       desc = "Flash"
  --     },
  --     {
  --       "S",
  --       mode = { "n", "o", "x" },
  --       function()
  --         require("flash").treesitter()
  --       end,
  --       desc = "Flash Treesitter"
  --     },
  --     {
  --       "r",
  --       mode = "o",
  --       function()
  --         require("flash").remote()
  --       end,
  --       desc = "Remote Flash"
  --     },
  --     {
  --       "R",
  --       mode = { "o", "x" },
  --       function()
  --         require("flash").treesitter_search()
  --       end,
  --       desc =
  --       "Treesitter Search"
  --     },
  --     {
  --       "<c-s>",
  --       mode = { "c" },
  --       function()
  --         require("flash").toggle()
  --       end,
  --       desc =
  --       "Toggle Flash Search"
  --     },
  --   },
  -- },
  -- {
  --   'christoomey/vim-tmux-navigator',
  --   lazy = false,
  -- },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})




local volarAttached = false
local tsserverAttached = false

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.name == 'tsserver' then
     client.stop()
    end
    -- print(client.name)
    -- if client.server_capabilities.completionProvider then
    --   vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- end
    -- if client.server_capabilities.definitionProvider then
    --   vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    -- end
  end,
})





-- Register linters and formatters per language
-- local eslint = require("efmls-configs.linters.eslint")
-- local prettier = require("efmls-configs.formatters.prettier")
-- local stylua = require("efmls-configs.formatters.stylua")
-- local languages = {
--   typescript = { eslint, prettier },
--   javascript = { eslint, prettier },
--   lua = { stylua },
-- }

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require("efmls-configs.defaults").languages()
--
-- local efmls_config = {
--   filetypes = vim.tbl_keys(languages),
--   settings = {
--     rootMarkers = { ".git/" },
--     languages = languages,
--   },
--   init_options = {
--     documentFormatting = true,
--     documentRangeFormatting = true,
--   },
-- }
--
-- require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
--   -- Pass your custom lsp config below like on_attach and capabilities
--   --
--   -- on_attach = on_attach,
--   -- capabilities = capabilities,
-- }))

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false
vim.opt.incsearch = true -- Enable incremental search

-- Make line numbers default
vim.wo.number = true

-- Hide the mode in the command bar
vim.opt.showmode = false

-- vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.swapfile = false                               -- Disable nvim swapfile (for undo history)
vim.opt.backup = false                                 -- Disable nvim backup (for undo history)
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set the dir for undofile
vim.opt.undofile = true                                -- Tell undofile to manage all my undo history

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Disable line wrapping
vim.opt.wrap = false

vim.opt.scrolloff = 8         -- never show less than 8 lines above or below when vertically scrolling

vim.opt.colorcolumn = "80"    -- Mark column 80 to show optimum line length

vim.opt.nu = true             -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers

-- Map <leader>ln to toggle_hybrid_line_numbers function
vim.keymap.set("n", "<leader>ln", function()
  local is_hybrid = vim.wo.relativenumber
  if is_hybrid then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end)

vim.opt.tabstop = 2      -- Set my tabstop width
vim.opt.softtabstop = 2  -- Set my soft tabstop width
vim.opt.shiftwidth = 2   -- Set my shift width
vim.opt.expandtab = true -- Set expand tab to true

vim.opt.smartindent = true

vim.opt.splitbelow = true -- Split new horizontal windows below the current one
vim.opt.splitright = true -- Split new vertical windows to the right of the current one

-- Treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Harpoon remaps
-- require('harpoon').setup()
-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")

-- vim.keymap.set("n", "<leader>a", mark.add_file)
-- vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
-- vim.keymap.set("n", "<C-n>", ui.nav_next)
-- vim.keymap.set("n", "<C-p>", ui.nav_prev)

-- vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
-- vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
-- vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
-- vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
-- end Harpoon

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      n = {
        ["<C-d>"] = require("telescope.actions").delete_buffer,
      },
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = require("telescope.actions").delete_buffer,
        ["<esc>"] = actions.close, -- Prevents Telescope from entering a normal-like mode when hitting escape
      },
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- My remaps

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader><Esc>", vim.cmd.Ex, { desc = "Hide buffer and return to Netrw Explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves highlighted lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves highlighted lines up" })

vim.keymap.set(
  "n",
  "J",
  "mzJ`z",
  { desc = "Appends the line below to the current line, but keeps the cursor in place" }
)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scrolls down a half-page, but keeps the cursor vertically centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scrolls up a half-page, but keeps the cursor vertically centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Greatest remap ever" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to the system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank to the system clipboard" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Saves you from accidentally closing the window" })

vim.keymap.set("n", "[c", vim.cmd.cp, { desc = "Go to the previous Qui[c]kfix error", silent = true })
vim.keymap.set("n", "]c", vim.cmd.cn, { desc = "Go to the next Qui[c]kfix error", silent = true })

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Search and replace

-- vim.keymap.set("n", "<leader><leader>", [[gcc]])

-- vim.keymap.set("n", "<leader><leader>", function()
--   vim.cmd("so")
-- end, { desc = "Quickly source the current file" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessioniser<CR>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.dotfiles/bin/.local/scripts/tmux-sessioniser<CR>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux-nvim-sessioniser<CR>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format the current buffer using LSP" })

-- vim.keymap.set("n", "<C-h>", vim.cmd.TmuxNavigateLeft);
-- vim.keymap.set("n", "<C-j>", vim.cmd.TmuxNavigateDown);
-- vim.keymap.set("n", "<C-k>", vim.cmd.TmuxNavigateUp);
-- vim.keymap.set("n", "<C-l>", vim.cmd.TmuxNavigateRight);
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch focus to the split buffer LEFT of the current buffer." })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch focus to the split buffer BELOW the current buffer." })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch focus to the split buffer ABOVE the current buffer." })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch focus to the split buffer RIGHT of the current buffer." })
-- vim.keymap.set({"n", "v"}, "<C-.>", "gc")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree", noremap = true })

-- Obsidian
vim.keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })

-- -- Neo Tree
-- vim.keymap.set('n', '<C-e>', '<Cmd>Neotree source=filesystem reveal=true position=right toggle<CR>')

-- Buffers
-- vim.keymap.set("n", "<C-w>", vim.cmd.bd, { desc = "Closes the current buffer" })
vim.keymap.set("n", "<leader>w", ":bp|bd #<CR>", { desc = "Closes the current buffer" })
vim.keymap.set("n", "<C-n>", vim.cmd.bn, { desc = "Navigates to the next buffer" })
vim.keymap.set("n", "<C-p>", vim.cmd.bp, { desc = "Navigates to the previous buffer" })

-- Trouble
vim.keymap.set("n", "<leader>xx", function()
  require("trouble").open()
end)
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").open("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").open("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").open("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").open("loclist")
end)
vim.keymap.set("n", "gR", function()
  require("trouble").open("lsp_references")
end)

-- Todo Comments
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next [t]odo comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous [t]odo comment" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { "c", "cpp", "go", "javascript", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim" },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,
  ignore_install = { "netrw", "fugitive" },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Enter>",
      node_incremental = "<Enter>",
      scope_incremental = "<c-s>",
      node_decremental = "<BS>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ['<leader>a'] = '@parameter.inner',
    --   },
    --   swap_previous = {
    --     ['<leader>A'] = '@parameter.inner',
    --   },
    -- },
  },
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  -- eslint = {},
  -- prettier = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- TODO: move this to the new file
-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

---@diagnostic disable-next-line: missing-fields
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Incline configuration

local function get_diagnostic_label(props)
  local icons = { error = "", warn = "", info = "", hint = "" }
  local label = {}

  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    if n > 0 then
      table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
    end
  end
  if #label > 0 then
    table.insert(label, { "| " })
  end
  return label
end
-- local function get_git_diff(props)
--   local icons = { removed = "", changed = "", added = "" }
--   local labels = {}
--   local signs = vim.api.nvim_buf_get_var(props.buf, "gitsigns_status_dict")
--   -- local signs = vim.b.gitsigns_status_dict
--   for name, icon in pairs(icons) do
--     if tonumber(signs[name]) and signs[name] > 0 then
--       table.insert(labels, { icon .. " " .. signs[name] .. " ",
--         group = "Diff" .. name
--       })
--     end
--   end
--   if #labels > 0 then
--     table.insert(labels, { '| ' })
--   end
--   return labels
-- end

require("incline").setup({
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
    local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"

    local buffer = {
      { get_diagnostic_label(props) },
      -- { get_git_diff(props) },
      { ft_icon,                    guifg = ft_color },
      { " " },
      { filename,                   gui = modified },
    }
    return buffer
  end,
})

-- end Incline configuration

-- -- Volar LSP config for Vue
--
-- local lspconfig = require 'lspconfig'
-- local lspconfig_configs = require 'lspconfig.configs'
-- local lspconfig_util = require 'lspconfig.util'
--
-- local function on_new_config(new_config, new_root_dir)
--   local function get_typescript_server_path(root_dir)
--     local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
--     return project_root and
--         (lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
--         or ''
--   end
--
--   if
--       new_config.init_options
--       and new_config.init_options.typescript
--       and new_config.init_options.typescript.tsdk == ''
--   then
--     new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
--   end
-- end
--
-- local volar_cmd = { 'vue-language-server', '--stdio' }
-- local volar_root_dir = lspconfig_util.root_pattern 'package.json'
--
-- lspconfig_configs.volar_api = {
--   default_config = {
--     cmd = volar_cmd,
--     root_dir = volar_root_dir,
--     on_new_config = on_new_config,
--     filetypes = { 'vue' },
--     -- If you want to use Volar's Take Over Mode (if you know, you know)
--     --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
--     init_options = {
--       -- typescript = {
--       --   tsdk = ''
--       --   tsdk = '/Users/danwalsh/.nvm/versions/node/v20.4.0/lib/node_modules/typescript/lib'
--       --   tsdk = "/Users/danwalsh/.nvm/versions/node/v$(node -v | sed 's/v//')/lib/node_modules/typescript/lib"
--       -- },
--       languageFeatures = {
--         implementation = true, -- new in @volar/vue-language-server v0.33
--         references = true,
--         definition = true,
--         typeDefinition = true,
--         callHierarchy = true,
--         hover = true,
--         rename = true,
--         renameFileRefactoring = true,
--         signatureHelp = true,
--         codeAction = true,
--         workspaceSymbol = true,
--         completion = {
--           defaultTagNameCase = 'both',
--           defaultAttrNameCase = 'kebabCase',
--           getDocumentNameCasesRequest = false,
--           getDocumentSelectionRequest = false,
--         },
--       }
--     },
--   }
-- }
-- lspconfig.volar_api.setup {}
--
-- lspconfig_configs.volar_doc = {
--   default_config = {
--     cmd = volar_cmd,
--     root_dir = volar_root_dir,
--     on_new_config = on_new_config,
--
--     filetypes = { 'vue' },
--     -- If you want to use Volar's Take Over Mode (if you know, you know):
--     --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
--     init_options = {
--       -- typescript = {
--       --   tsdk = ''
--       --   tsdk = '/Users/danwalsh/.nvm/versions/node/v20.4.0/lib/node_modules/typescript/lib'
--       --   tsdk = "/Users/danwalsh/.nvm/versions/node/v$(node -v | sed 's/v//')/lib/node_modules/typescript/lib"
--       -- },
--       languageFeatures = {
--         implementation = true, -- new in @volar/vue-language-server v0.33
--         documentHighlight = true,
--         documentLink = true,
--         codeLens = { showReferencesNotification = true },
--         -- not supported - https://github.com/neovim/neovim/pull/15723
--         semanticTokens = false,
--         diagnostics = true,
--         schemaRequestService = true,
--       }
--     },
--   }
-- }
-- lspconfig.volar_doc.setup {}
--
-- lspconfig_configs.volar_html = {
--   default_config = {
--     cmd = volar_cmd,
--     root_dir = volar_root_dir,
--     on_new_config = on_new_config,
--
--     filetypes = { 'vue' },
--     -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
--     --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--     init_options = {
--       -- typescript = {
--       --   tsdk = ''
--       --   tsdk = '/Users/danwalsh/.nvm/versions/node/v20.4.0/lib/node_modules/typescript/lib'
--       --   tsdk = "/Users/danwalsh/.nvm/versions/node/v$(node -v | sed 's/v//')/lib/node_modules/typescript/lib"
--       -- },
--       documentFeatures = {
--         selectionRange = true,
--         foldingRange = true,
--         linkedEditingRange = true,
--         documentSymbol = true,
--         -- not supported - https://github.com/neovim/neovim/pull/13654
--         documentColor = false,
--         documentFormatting = {
--           defaultPrintWidth = 100,
--         },
--       }
--     },
--   }
-- }
-- lspconfig.volar_html.setup {}
--
-- -- end Volar config

-- My global functions

-- Eslint a whole project
-- function LintProject()
--   -- Set the makeprg option to the specified command
--   vim.api.nvim_command("set makeprg=eslint")
--
--   -- Run :make command
--   vim.api.nvim_command("make")
--
--   -- Call :cope to display the output in the quick fix list
--   vim.api.nvim_command("cope")
-- end
