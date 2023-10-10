return {
  -- UndoTree
  "mbbill/undotree",
  config = function()
    vim.opt.swapfile = false                               -- Disable nvim swapfile (for undo history)
    vim.opt.backup = false                                 -- Disable nvim backup (for undo history)
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set the dir for undofile
    vim.opt.undofile = true                                -- Tell undofile to manage all my undo history
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree", noremap = true })
  end
}
