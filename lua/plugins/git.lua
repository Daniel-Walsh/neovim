return {
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },
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
  },
}
