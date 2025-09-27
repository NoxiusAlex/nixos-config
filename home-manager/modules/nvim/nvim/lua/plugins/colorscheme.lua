return {
  {
    "sinedka/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      -- vim.cmd("colorscheme " .. EcoVim.colorscheme)
      require("config.colorscheme")
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
}
