vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.number = true
--vim.opt.relativenumber = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.expandtab = true
vim.opt.tabstop = 2

-- key mappings
vim.g.mapleader = ","
vim.api.nvim_set_keymap('n',   -- n for normal mode
        '<Leader>w', ':w<CR>',
        { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n',   -- n for normal mode
        '<Leader>q', ':q<CR>',
        { noremap = true, silent = true }
)

require("config.lazy")
