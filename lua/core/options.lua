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
vim.o.updatetime = 300
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.termguicolors = true

-- Completion settings
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}

vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("AnoDiagnosticFloat", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      scope = "cursor",
      close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
    })
  end,
})

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

-- Unused remote-plugin providers: disabled so :checkhealth stays signal, not noise.
-- Re-enable a line here if you ever install a plugin that needs that host.
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
