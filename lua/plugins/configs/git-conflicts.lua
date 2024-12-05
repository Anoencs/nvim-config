vim.cmd [[
  highlight MyIncoming guifg=#282828 guibg=#fabd2f
  highlight MyCurrent guifg=#282828 guibg=#83a598
]]

-- Then setup the plugin
require('git-conflict').setup({
    default_mappings = true,
    default_commands = true,
    disable_diagnostics = false,
    list_opener = 'copen',
    highlights = {
       incoming = 'MyIncoming',
        current = 'MyCurrent',
    }
})
