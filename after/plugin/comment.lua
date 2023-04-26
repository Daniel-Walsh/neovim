-- require('Comment').setup()
require('nvim_comment').setup({
  -- should comment out empty or whitespace only lines
  comment_empty = false,
  -- Visual/Operator mapping left hand side
  operator_mapping = "<leader>/" -- default = "gc"
})
