require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  concurrency = 10,
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin", },
    },
  },
  debug = false,
  ui = {
    border = "rounded",
  },
})

vim.keymap.set("n", "<leader>/l", "<cmd>:Lazy<cr>")
