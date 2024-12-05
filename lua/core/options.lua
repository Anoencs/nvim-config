-- Encoding and colors
vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"

-- Leader key
vim.g.mapleader = " "


-- Editor settings
vim.opt.guicursor = "i:block"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.swapfile = false

-- Global options
vim.o.hlsearch = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.termguicolors = true

-- Completion settings
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- Fixed column for diagnostics
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Custom highlighting
vim.cmd([[
    augroup CustomCommentCollor
        autocmd!
        autocmd VimEnter * hi Comment guifg=#2ea542
    augroup END
]])

-- Disable match brackets
vim.cmd([[
    augroup CustomHI
        autocmd!
        autocmd VimEnter * NoMatchParen 
    augroup END
]])

vim.o.background = "dark"
