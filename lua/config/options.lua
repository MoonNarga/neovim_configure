-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.g.ai_cmp = true
