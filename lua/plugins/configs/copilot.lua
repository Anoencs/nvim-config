-- Copilot configuration
require("CopilotChat").setup {
    debug = true, -- Enable debugging
}

vim.g.copilot_no_tab_map = true

-- Copilot mappings
vim.keymap.set('i', '<M-m>', 'copilot#Accept("\\<CR>")', {
   expr = true,
   replace_keycodes = false
})
