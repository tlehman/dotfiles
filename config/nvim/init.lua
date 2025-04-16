vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.number = true
--vim.opt.relativenumber = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- key mappings
vim.g.mapleader = ","
opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', opts)

require("config.lazy")
