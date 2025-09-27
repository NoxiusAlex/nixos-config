return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",

      -- LuaSnip
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/snippets" },
          })
        end,
      },

      -- Windsurf AI completion
      -- {
      --   "Exafunction/windsurf.nvim",
      --   event = "VeryLazy",
      --   config = function()
      --     require("codeium").setup({
      --       -- тут можно указать API-ключ и опции, если нужно
      --       -- api_key = os.getenv("WINDSURF_API_KEY"),
      --       -- enable_inline_completion = true,
      --       -- enable_suggestions = true,
      --     })
      --   end,
      -- },
      -- "windsurf-ai/cmp-windsurf", -- источник для nvim-cmp
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local kind_icons = {
        Copilot = "",
        Windsurf = "󱚣", -- иконка для Windsurf
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',
        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',
        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      }

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-j>"] = cmp.mapping.scroll_docs(4),
          ["<S-k>"] = cmp.mapping.scroll_docs(-4),
        }),

        sources = cmp.config.sources({
          -- { name = "windsurf" }, -- 🔥 Windsurf AI
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer" },
        }),

        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = (kind_icons[vim_item.kind] or "") .. " " .. vim_item.kind
            vim_item.menu = ({
              -- windsurf = "[AI]",
              nvim_lsp = "[LSP]",
              buffer = "[Buf]",
              path = "[Path]",
              luasnip = "[Snip]",
            })[entry.source.name]
            return vim_item
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
}

