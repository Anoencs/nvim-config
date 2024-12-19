--local nvim_lsp = require('lspconfig')
-- Golangci-lint configuration
-- local function configure_golangci_lint()
--     local lspconfig = require('lspconfig')
--    
--     if vim.g.go_linter_enabled then
--         lspconfig.golangci_lint_ls.setup({
--             filetypes = {'go', 'gomod'},
--             root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
--             init_options = {
--                 command = { 
--                     "golangci-lint", 
--                     "run", 
--                     "--enable-all", 
--                     "--disable", "lll",
--                     "--out-format", 
--                     "json",
--                     "--issues-exit-code=1"
--                 }
--             }
--         })
--         vim.notify("GoLangCI Linter Enabled", vim.log.levels.INFO)
--     else
--         local clients = vim.lsp.get_active_clients({name = "golangci_lint_ls"})
--         for _, client in ipairs(clients) do
--             local ns = vim.lsp.diagnostic.get_namespace(client.id)
--             vim.diagnostic.reset(ns)
--             client.stop()
--         end
--         vim.notify("GoLangCI Linter Disabled", vim.log.levels.INFO)
--     end
-- end
--
-- -- Function to toggle linter
-- local function toggle_golangci_lint()
--     vim.g.go_linter_enabled = not vim.g.go_linter_enabled
--     configure_golangci_lint()
-- end
--
-- -- Setup keymaps
-- vim.keymap.set('n', '<leader>lt', toggle_golangci_lint, { 
--     noremap = true, 
--     desc = "Toggle GoLangCI Linter" 
-- })
--
-- vim.keymap.set('n', '<leader>ll', function()
--     if vim.g.go_linter_enabled then
--         vim.cmd("LspRestart golangci_lint_ls")
--         vim.notify("GoLangCI Linter Manually Run", vim.log.levels.INFO)
--     else
--         vim.notify("GoLangCI Linter is disabled", vim.log.levels.WARN)
--     end
-- end, { 
--     noremap = true, 
--     desc = "Run GoLangCI Linter" 
-- })
--
-- Go setup
require('go').setup({
    disable_defaults = false,
    go = 'go',
    goimports = 'gopls',
    gofmt = 'gopls',
    max_line_len = 0,
    tag_transform = false,
    tag_options = 'json=omitempty',
    gotests_template = "",
    gotests_template_dir = "",
    comment_placeholder = ' 󰟓  ',
    icons = {breakpoint = '', currentpos = ''},
    verbose = false,
    lsp_cfg = false,
    lsp_gofumpt = true,
    lsp_on_attach = nil,
    lsp_keymaps = true,
    lsp_codelens = true,
    lsp_document_formatting = true,
    lsp_inlay_hints = {
        enable = true,
        style = 'eol',
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_variable_name = true,
        parameter_hints_prefix = " ",
        show_parameter_hints = true,
        other_hints_prefix = "=> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 6,
        highlight = "Comment",
    },
    gopls_remote_auto = true,
    gocoverage_sign = "█",
    dap_debug = true,
    dap_debug_keymap = true,
    dap_debug_gui = true,
    dap_debug_vt = true,
    build_tags = "",
    textobjects = true,
    test_runner = 'go',
    verbose_tests = true,
    run_in_floaterm = false,
    trouble = false,
    test_efm = false,
    luasnip = false,
})
require('lspconfig').gopls.setup{
    settings = {
        gopls = {
            analyses = {
                vulncheck = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
        },
    },
}

-- Initial linter setup
--vim.g.go_linter_enabled = true
--configure_golangci_lint()
