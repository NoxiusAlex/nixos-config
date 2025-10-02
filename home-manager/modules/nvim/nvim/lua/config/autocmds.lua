-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 }) end })
-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.tex" },
  command = "setlocal spell" })
-- Show `` in specific files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.json" },
  command = "setlocal conceallevel=0" })

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, "which-key")
if not present then return end
local _, pwk = pcall(require, "plugins.which-key.setup")

vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.md",
  callback = function() pwk.attach_markdown(0) end })
vim.api.nvim_create_autocmd("BufEnter", { pattern = { "package.json" },
  callback = function() pwk.attach_npm(0) end })
vim.api.nvim_create_autocmd("BufEnter", { pattern = { "*test.js", "*test.ts", "*test.tsx", "*spec.ts", "*spec.tsx" },
  callback = function() pwk.attach_jest(0) end })
vim.api.nvim_create_autocmd("FileType", { pattern = "spectre_panel",
  callback = function() pwk.attach_spectre(0) end })
vim.api.nvim_create_autocmd("FileType", { pattern = "NvimTree",
  callback = function() pwk.attach_nvim_tree(0) end })

-- File Type Plugin Lazy Loading
local lazy = vim.api.nvim_create_augroup("lazy", {})
vim.api.nvim_create_autocmd(
  "UIEnter",
  {
    group = lazy,
    pattern = { "*.test.ts", "*.test.tsx", "*.spec.ts", "*.spec.tsx", "*.test.js", "*.spec.js" },
    callback = function()
      print("lazy loading lua plugins")
      require "lazy.loader".load({
        plugins = { "neotest", }
      })
    end
  }
)

-- Функция для сборки C++ файла
local function build_cpp_file()
  local current_file = vim.fn.expand("%:p")
  local file_name = vim.fn.expand("%:t:r")
  local file_dir = vim.fn.expand("%:p:h")
  
  -- Проверяем, что это C++ файл
  if not vim.endswith(current_file, ".cpp") and not vim.endswith(current_file, ".cc") and not vim.endswith(current_file, ".cxx") then
    vim.notify("Это не C++ файл!", vim.log.levels.ERROR)
    return nil
  end
  
  -- Создаем путь к исполняемому файлу
  local executable_path = file_dir .. "/" .. file_name
  
  -- Команда сборки
  local build_cmd = string.format("cd %s && clang++ -g -O0 -o %s %s", 
    vim.fn.shellescape(file_dir),
    vim.fn.shellescape(file_name),
    vim.fn.shellescape(current_file)
  )
  
  vim.notify("Сборка C++ файла...", vim.log.levels.INFO)
  
  -- Выполняем сборку
  local result = vim.fn.system(build_cmd)
  local exit_code = vim.v.shell_error
  
  if exit_code ~= 0 then
    vim.notify("Ошибка сборки: " .. result, vim.log.levels.ERROR)
    return nil
  end
  
  vim.notify("Сборка завершена успешно!", vim.log.levels.INFO)
  return executable_path
end

-- Функция для поиска файла с тестом
local function find_test_file(test_number)
  local current_file = vim.fn.expand("%:p")
  local file_name = vim.fn.expand("%:t:r")  -- имя файла без расширения
  local file_dir = vim.fn.expand("%:p:h")
  
  -- Формируем имя файла с тестом
  local test_file_name = file_name .. "_input" .. test_number .. ".txt"
  local test_file_path = file_dir .. "/" .. test_file_name
  
  -- Проверяем, существует ли файл с тестом
  if vim.fn.filereadable(test_file_path) == 1 then
    return test_file_path
  end
  
  -- Если файл не найден, показываем ошибку
  vim.notify("Файл с тестом не найден: " .. test_file_name, vim.log.levels.ERROR)
  return nil
end

-- Функция для запуска DAP с тестом
local function run_dap_with_test(test_number)
  local executable_path = build_cpp_file()
  if not executable_path then
    return
  end
  
  local test_file_path = find_test_file(test_number)
  if not test_file_path then
    return
  end
  
  local dap = require("dap")
  
  -- Конфигурация DAP для запуска с тестом
  local config = {
    name = "Запуск с тестом " .. test_number,
    type = "codelldb",
    request = "launch",
    program = executable_path,
    cwd = vim.fn.expand("%:p:h"),
    stopOnEntry = false,
    stdio = {test_file_path, null, null}
  }
  
  -- Запускаем DAP
  dap.run(config)
end

-- Пользовательская команда для запуска теста
vim.api.nvim_create_user_command("RunTest", function(opts)
  local test_number = opts.args
  if test_number == "" then
    vim.notify("Укажите номер теста: :RunTest <номер>", vim.log.levels.ERROR)
    return
  end
  
  run_dap_with_test(test_number)
end, {
  nargs = 1,
  desc = "Собрать C++ файл и запустить DAP с файлом теста (имя_input<номер>.txt)"
})
