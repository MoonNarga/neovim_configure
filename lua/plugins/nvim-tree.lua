return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup()

        --插件
        --nvim-tree
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
}