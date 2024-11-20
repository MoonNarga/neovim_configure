return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP 补全
      "hrsh7th/cmp-buffer", -- 缓冲区补全
      "hrsh7th/cmp-path", -- 文件路径补全
      "hrsh7th/cmp-cmdline", -- 命令行补全
      "hrsh7th/cmp-nvim-lua", -- Lua 补全
      "L3MON4D3/LuaSnip", -- 代码片段
    },
    opts = function()
      local cmp = require("cmp")
      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        cmdline = {
          [":"] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = "cmdline" },
            }, {
              { name = "path" },
            }),
          },
          ["/"] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = "buffer" },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")

      -- 设置插入模式的补全
      cmp.setup(opts)

      -- 设置命令行模式的补全
      for cmd_type, config in pairs(opts.cmdline) do
        cmp.setup.cmdline(cmd_type, {
          mapping = config.mapping,
          sources = config.sources,
        })
      end
    end,
  },
}
