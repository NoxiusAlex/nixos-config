return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",            -- UI для удобства
    "nvim-neotest/nvim-nio",  -- ✅ обязательная зависимость
    "theHamsta/nvim-dap-virtual-text", -- виртуальный текст с переменными
  },

  keys = {
    { "<leader>lb", "<cmd>DapToggleBreakpoint<CR>",            desc = "toggle breakpoint" },
    { "<leader>lc",       function() require("dap").continue() end,  desc = "DAP continue" },
    { "<leader>lo",      function() require("dap").step_over() end, desc = "DAP step over" },
    { "<leader>li",      function() require("dap").step_into() end, desc = "DAP step into" },
    { "<leader>lO",      function() require("dap").step_out() end,  desc = "DAP step out" },
    { "<leader>lr", function() require("dap").repl.open() end, desc = "DAP REPL" },
    { "<leader>ll", function() require("dap").run_last() end,  desc = "DAP run last" },
    { "<Leader>lB", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
  },
  config = function()
    local dap = require("dap")

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i=dap" }
    }

    dap.configurations.cpp = {
      {
        name = "Запустить программу",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Путь к исполняемому файлу: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp

    -- DAP UI
    local dapui = require("dapui")
    dapui.setup()

    -- Автооткрытие/закрытие UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Virtual text
    require("nvim-dap-virtual-text").setup()
  end,
}
