local spec = {
    "yunusey/codeforces-nvim",
    dependencies = { "nvim-lua/plenary.nvim" } -- optional, used for testing
}

spec.config = function()
    require('codeforces-nvim').setup {
        use_term_toggle = true,
        cf_path = "/home/sinedka/cf",
        timeout = 15000,
        compiler = {
            cpp = { "g++", "@.cpp", "-o", "@" },
            py = {}
        },
        run = {
            cpp = { "@" },
            py = { "python3", "@.py" }
        },
        -- notify = function(title, message, type)
        --     local notify = require('notify')
        --     if message == nil then
        --         notify(title, type, {
        --             render = "minimal",
        --         })
        --     else
        --         notify(message, type, {
        --             title = title,
        --         })
        --     end
        -- end
    }
end

return spec
