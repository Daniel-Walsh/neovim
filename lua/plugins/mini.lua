return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			-- require("mini.surround").setup()

			require("mini.pairs").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			-- local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			-- statusline.setup({
			-- 	content = {
			-- 		inactive = function()
			-- 			return "%#MiniStatuslineInactive#  %n  %F%="
			-- 		end,
			-- 	},
			-- 	use_icons = vim.g.have_nerd_font,
			-- })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- 	return "%2l:%-2v"
			-- end

			---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_filename = function(args)
			-- 	-- In terminal always use plain name
			-- 	if vim.bo.buftype == "terminal" then
			-- 		return "%t"
			-- 	elseif statusline.is_truncated(args.trunc_width) then
			-- 		-- File name with 'truncate', 'modified', 'readonly' flags
			-- 		-- Use relative path if truncated
			-- 		return " %n  %f%m%r"
			-- 	else
			-- 		-- Use fullpath if not truncated
			-- 		return " %n  %F%m%r"
			-- 	end
			-- end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
