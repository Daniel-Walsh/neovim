return {
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
      local tokyocolours = require("tokyonight.colors").setup({ style = "storm" })

      vim.cmd.colorscheme("tokyonight")

      -- Change our line number colours and make the current ln stand out
      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = tokyocolours.comment })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = tokyocolours.yellow })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = tokyocolours.comment })
    end,
  },
}
