Snacks = Snacks

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile      = { enabled = true },
      dashboard    = { enabled = false },
      indent       = { enabled = false },
      input        = { enabled = true },
      notifier     = { enabled = true },
      explorer     = { enabled = true },
      picker       = {
        enabled = true,
        explorer = {
          opts = {
            win = {
              list = {
                keys = {
                  ["<c-]>"] = "explorer_cd",
                }
              }
            }
          }
        },
        previewers = {
          git = {
            native = true, -- use native (terminal) or Neovim for previewing git diffs and commits
          },
        },
        win = {
          -- input window
          input = {
            keys = {
              -- ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },
              ["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },
            },
          },
        },
      },
      quickfile    = { enabled = false },
      scroll       = { enabled = false },
      statuscolumn = {
        enabled = true,
      },
      words        = { enabled = false },
    },
    keys = {
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Lazygit                                                 │
      -- ╰─────────────────────────────────────────────────────────╯
      { "<leader>gg",  function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gla", function() Snacks.lazygit.log() end,                                    desc = "Lazygit Log (cwd)" },
      { "<leader>glc", function() Snacks.lazygit.log_file() end,                               desc = "Lazygit Current File History" },
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Picker                                                  │
      -- ╰─────────────────────────────────────────────────────────╯
      { "<leader>e",  function() Snacks.picker.explorer() end,                                desc = "explorer" },
      { "<leader>pS",  function() Snacks.picker.smart() end,                                   desc = "smart files" },
      { "<leader>sg", function() Snacks.picker.grep() end,                                    desc = "grep" },
      { "<leader>sw",  function() Snacks.picker.grep_word() end,                               desc = "grep word",                   mode = { "n", "v" } },

      { "<leader>sp",  function() Snacks.picker.projects() end,                                desc = "projects list" },

      { "<leader>cd",  function() Snacks.picker.diagnostics() end,                             desc = "diagnostics" },

      { "<leader>sf",  function() Snacks.picker.files() end,                                   desc = "files" },
      { "<leader>sb",  function() Snacks.picker.buffers() end,                                 desc = "buffers" },
      { "<leader>sh",  function() Snacks.picker.recent() end,                                  desc = "recent files" },
      { "<leader>sH",  function() Snacks.picker.command_history() end,                         desc = "command history" },
      { "<leader>ss",  function() Snacks.picker.search_history() end,                          desc = "search history" },
      { "<leader>sq",  function() Snacks.picker.qflist() end,                                  desc = "quickfix list" },

      { "<leader>gf",  function() Snacks.picker.git_files() end,                               desc = "git files" },
      { "<leader>gs",  function() Snacks.picker.git_status() end,                              desc = "git status" },
      { "<leader>glA", function() Snacks.picker.git_log() end,                                 desc = "log" },
      { "<leader>glC", function() Snacks.picker.git_log_file() end,                            desc = "file commits" },
    },
  }
}
