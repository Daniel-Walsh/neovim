return {
  {
    "ray-x/go.nvim",
    -- optional package dependencies below
    dependencies = { 
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {
      "CmdlineEnter"
    },
    ft = { 
      "go",
      "gomod"
    },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
