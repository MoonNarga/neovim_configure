return {
    "akinsho/toggleterm.nvim",
    config = function()
        local status_ok, toggleterm = pcall(require, "toggleterm")
        if not status_ok then
            return
        end

        toggleterm.setup({
            open_mapping = [[<c-\>]],
            -- 打开新终端后自动进入插入模式
            start_in_insert = true,
            -- 在当前buffer的下方打开新终端
            direction = 'float',
        })

        function _G.set_terminal_keymaps()
            local opts = {noremap = true}
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd([[
            autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()
        ]])

        local Terminal  = require('toggleterm.terminal').Terminal
        local zsh = Terminal:new({ hidden = true })

        function _zsh_toggle()
            zsh:toggle()
        end

        vim.keymap.set("n", "<leader>t", "<cmd>lua _zsh_toggle()<CR>", {noremap = true, silent = true})
    end,
}