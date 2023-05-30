if vim.g.vscode then
    -- VSCode extension
    require("vscode.keymaps")
    require("vscode.options")

else
    -- ordinary Neovim
    require("plugins.plugins-setup")

    require("core.options")
    require("core.keymaps")

    require("plugins.nvim-tree")
    require("plugins.lualine")
    require("plugins.treesitter")
    require("plugins.lsp")
    require("plugins.cmp")
    require("plugins.comment")
    require("plugins.autopairs")
    require("plugins.bufferline")
    require("plugins.gitsigns")
    require("plugins.telescope")
    require("plugins.lsp-config")
    require("plugins.toggleterm")
    require("plugins.symbols-outline")
    require("plugins.formatter")
end

