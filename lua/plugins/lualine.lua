return {
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
              icon = "󰾺",
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
  }
}
