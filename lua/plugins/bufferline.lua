return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true,
        --切换buffer
        vim.keymap.set("n", "L", ":bnext<CR>")
        vim.keymap.set("n", "H", ":bprevious<CR>")
    end,
}
