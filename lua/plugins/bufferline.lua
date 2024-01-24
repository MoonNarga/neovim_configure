return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup{
            options = {
                diagnostics = "nvim_lsp",
                offsets = {{
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left"
                }}
            }
        }
        vim.keymap.set('n', '<C-h>', ':BufferLineCyclePrev<CR>', opt)
        vim.keymap.set('n', '<C-l>', ':BufferLineCycleNext<CR>', opt)
        vim.keymap.set('n', '<leader>bd', ':bdelete %<CR>', {noremap = true, silent = true})
        vim.keymap.set('n', '<leader>bp', ':BufferLinePickClose<CR>', {noremap = true, silent = true})
        vim.keymap.set('n', '<leader>bc', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', {noremap = true, silent = true})
    end
}
