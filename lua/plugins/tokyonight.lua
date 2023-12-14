return {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "moon" },
    priority = 1000,
    config = function()
        vim.cmd[[colorscheme tokyonight]]
    end,
}
