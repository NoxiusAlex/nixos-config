local path_present, Path = pcall(require, "plenary.path")
if not path_present then
  return
end

return {
  {
    "Shatur/neovim-session-manager",
    lazy = false,
    config = function()
      local config_group = vim.api.nvim_create_augroup('SessionManagerGroup', {})

      require('session_manager').setup {
        sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),             -- The directory where the session files will be saved.
        path_replacer = '__',                                                    -- The character to which the path separator will be replaced for session files.
        colon_replacer = '++',                                                   -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true,                                            -- Automatically save last session on exit and on session switch.
        max_path_length = 80,                                                    -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      }

      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = "SessionLoadPost",
        group = config_group,
        callback = function()
          Snacks.explorer.open()
          vim.notify('Session loaded!', 'info', { title = 'Session Manager' })
        end,
      })

      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = "SessionSavePost",
        group = config_group,
        callback = function()
          vim.notify('Session saved!', 'info', { title = 'Session Manager', bufid = 0 })
          Snacks.explorer.open()
        end,
      })
    end,
    keys = {
      { "<leader>psm", "<cmd>SessionManager available_commands<CR>", desc = "available commands" },
    }
  },
}
