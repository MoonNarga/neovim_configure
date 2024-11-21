return {
  "hrsh7th/cmp-cmdline",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "cmdline" },
      }, {
        { name = "path" },
      }),
    })
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}
