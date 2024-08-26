return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- local toykocolours = require("tokyonight.colors").setup({ style = "day" })
		require("lualine").setup({
			options = {
				-- icons_enabled = true,
				theme = "tokyonight-day",
				-- component_separators = "|",
				-- section_separators = "",
			},
		})
	end,
}
