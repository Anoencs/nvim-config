local lsp = require("lsp-zero")

-- Basic LSP setup
lsp.preset("recommended")

-- Configure signs
lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

-- Server setup
lsp.setup_servers({
    "gopls",
    "eslint",
    "rust_analyzer",
    "move_analyzer",
    "ts_ls",
    "pylsp",
    "pylyzer",
    "emmet_language_server",
    "eslint",
    "solidity",
    "solidity_ls_nomicfoundation",
    "solidity_ls",
 --   "golangci_lint_ls"
})
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts) 
	vim.keymap.set('n', '<leader>rn','<cmd>lua vim.lsp.buf.rename()<cr>',opts)
  end
})


-- Format on save setup
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_format_on_save = function(bufnr)
    vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end

-- LSP Attach function
lsp.on_attach(function(client, bufnr)
    lsp_format_on_save(bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)

-- Diagnostics configuration
vim.diagnostic.config({
    -- signs = false,
    -- virtual_text = true,
    -- underline = false,
    virtual_text = {
        prefix = '●',
        source = "always",
    },
    float = {
        source = "always",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,

})

lsp.setup()

-- require all specific language configurations
require("plugins.configs.lsp.golang")
require("plugins.configs.lsp.rust")

-- local M = {}
--
-- function M.setup()
--     require("plugins.configs.lsp.golang").setup()
--     require("plugins.configs.lsp.rust").setup()
--     -- Add other LSP setups here
-- end
--
-- return M
