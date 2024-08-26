return {
	-- {
	--   "catppuccin/nvim",
	--   name = "catppuccin",
	--   priority = 1000,
	--   config = function ()
	--     require("catppuccin").setup({
	--       flavour = "mocha",
	--       no_italic = true
	--     })
	--     vim.cmd.colorscheme("catppuccin-mocha")
	--
	--     local mocha = require("catppuccin.palettes").get_palette "mocha"
	--
	--     -- Change our line number colours and make the current ln stand out
	--     vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = mocha.surface1 })
	--     vim.api.nvim_set_hl(0, 'LineNr', { fg = mocha.yellow })
	--     vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = mocha.surface1 })
	--   end
	-- }
	{
		-- Theme inspired by Atom
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = {},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				style = "day",
				styles = {
					-- functions = {}, -- disable italic for functions
				},
			})
			local tokyocolours = require("tokyonight.colors").setup({ style = "day" })

			vim.cmd.colorscheme("tokyonight-day")

			-- Change our line number colours and make the current ln stand out
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = tokyocolours.comment })
			vim.api.nvim_set_hl(0, "LineNr", { fg = tokyocolours.yellow })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = tokyocolours.comment })
		end,
	},
}
