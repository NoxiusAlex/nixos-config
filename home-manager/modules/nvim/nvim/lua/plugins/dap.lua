function ShowBreakpointsSnacks()
  local dap = require('dap')
  local snacks = require('snacks')


  local items = {}
  for file, bps in pairs(dap.breakpoints or {}) do -- <- dap.breakpoints, а не list_breakpoints()
    for _, bp in ipairs(bps) do
      table.insert(items, {
        text = file .. ":" .. bp.line,
        file = file,
        line = bp.line
      })
    end
  end

  if #items == 0 then
    print("Нет брекпоинтов")
    return
  end

  snacks.pick(items, {
    prompt = "Breakpoints",
    on_select = function(item)
      vim.cmd("e " .. item.file)
      vim.api.nvim_win_set_cursor(0, { item.line, 0 })
    end
  })
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",            -- UI для удобства
    "nvim-neotest/nvim-nio",           -- ✅ обязательная зависимость
  },

  keys = {
    { "<Leader>lb", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
    { "<F5>",       function() require("dap").continue() end,          desc = "DAP continue" },
    { "<F10>",      function() require("dap").step_over() end,         desc = "DAP step over" },
    { "<F11>",      function() require("dap").step_into() end,         desc = "DAP step into" },
    { "<S-F11>",    function() require("dap").step_out() end,          desc = "DAP step out" },
    { "<Leader>lp", function() ShowBreakpointsSnacks() end,            desc = "DAP show breakpoints list" },
    { '<Leader>lq', "<cmd>lua dap.terminate(); dapui.close()<CR>",     desc = "DAP close" },
    -- { "<leader>lr", function() require("dap").repl.open() end,         desc = "DAP REPL" },
    { "<leader>ll", function() require("dap").run_last() end,          desc = "DAP run last" },
  },
  config = function()
    local dap = require("dap")

    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = os.getenv("CODELLDB_PATH"), -- берём путь из переменной окружения
        args = { "--port", "${port}" },
      }
    }

    dap.configurations.cpp = {
      {
        name = "Запустить программу",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Путь к исполняемому файлу: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        setupCommands = {
          {
            text = 'settings set target.process.thread.step-avoid-regexp "^std::"',
            description = "Skip STL functions",
            ignoreFailures = true
          },
          {
            text = 'settings append target.process.thread.step-avoid-regexp "^__gnu_cxx::"',
            description = "Skip libstdc++ internals",
            ignoreFailures = true
          },
        }
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
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='Error', linehl='', numhl=''})
    vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='WarningMsg', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='', texthl='Normal', linehl='', numhl=''})
  end,
}
