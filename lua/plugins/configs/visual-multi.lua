local M = {}

function M.setup()
  print("=== VM Setup Started ===")
  -- Plugin settings
  vim.g.VM_theme = 'ocean'
  vim.g.VM_silent_exit = 1
  vim.g.VM_highlight_matches = 'underline'
  
  -- Create user commands for debugging
  vim.api.nvim_create_user_command('VMShowMaps', function()
    print(vim.inspect(vim.g.VM_maps))
  end, { desc = 'Show VM mappings' })
  
  vim.api.nvim_create_user_command('VMReload', function()
    vim.g.VM_maps = get_mappings()
    print('VM mappings reloaded')
  end, { desc = 'Reload VM mappings' })
end

vim.keymap.set('n', '<M-j>', function()
  vim.cmd('call vm#commands#add_cursor_down(0, v:count1)')
end, { desc = 'VM: Add cursor down' })

vim.keymap.set('n', '<M-k>', function()
  vim.cmd('call vm#commands#add_cursor_up(0, v:count1)')
end, { desc = 'VM: Add cursor up' })

if not vim.g.VM_maps then
  print("Testing VM config...")
  M.setup()
else
  print("VM already configured")
end

return M
