return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup {}
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
    -- keys = {
    --   -- disable the keymap to grep files
    -- --   {"<leader>/", false},
    --   -- change a keymap
    --   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    --   -- add a keymap to browse plugin files
    --   {
    --     "<leader>fp",
    --     function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
    --     desc = "Find Plugin File",
    --   },
    -- },
 }