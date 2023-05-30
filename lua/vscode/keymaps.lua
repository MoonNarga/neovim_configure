vim.g.mapleader = " "

local keymap = vim.keymap

--插入模式--

--视觉模式--
--单行多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

