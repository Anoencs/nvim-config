-- local dap = require('dap')
-- local dapui = require('dapui')
--
-- dapui.setup({
--     icons = { expanded = "▾", collapsed = "▸" },
--     mappings = {
--         expand = { "<CR>", "<2-LeftMouse>" },
--         open = "o",
--         remove = "d",
--         edit = "e",
--         repl = "r",
--         toggle = "t",
--     },
--     expand_lines = vim.fn.has("nvim-0.7"),
--     layouts = {
--         {
--             elements = {
--                 'scopes',
--                 'breakpoints',
--                 'stacks',
--                 'watches',
--             },
--             size = 40,
--             position = 'left',
--         },
--         {
--             elements = {
--                 'repl',
--                 'console',
--             },
--             size = 10,
--             position = 'bottom',
--         },
--     },
--     floating = {
--         max_height = nil,
--         max_width = nil,
--         border = "single",
--         mappings = {
--             close = { "q", "<Esc>" },
--         },
--     },
--     windows = { indent = 1 },
--     render = {
--         max_type_length = nil,
--     }
-- })
--
-- -- Automatically open and close the DAP UI
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--     dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     dapui.close()
-- end
--
-- dap.adapters.codelldb = {
--     type = 'server',
--     port = '${port}',
--     executable = {
--         command = vim.fn.expand('~/.local/share/nvim/mason/bin/codelldb'),
--         args = {'--port', '${port}'}
--     }
-- }
-- dap.adapters.delve = {
--     type = 'server',
--     port = '${port}',
--     executable = {
--         command = vim.fn.expand('~/.local/share/nvim/mason/bin/dlv'),
--         args = {'dap', '-l', '127.0.0.1:${port}'},
--     }
-- }
--
--
-- -- Configure debugger by language
-- -- For Golang
-- dap.configurations.go = {
--     {
--         type = "delve",
--         name = "Debug Package",
--         request = "launch",
--         mode = "debug",
--         program = "${workspaceFolder}",  -- This will debug the current package
--     },
--     {
--         type = "delve",
--         name = "Debug Current File",
--         request = "launch",
--         mode = "debug",
--         program = "${file}"
--     },
--     {
--         type = "delve",
--         name = "Debug Test",  -- Add configuration for debugging tests
--         request = "launch",
--         mode = "test",
--         program = "${file}"
--     },
--     {
--         type = "delve",
--         name = "Debug Test (go.mod)",
--         request = "launch",
--         mode = "test",
--         program = "./${relativeFileDirname}"
--     }
-- }
--
-- -- For Rust
-- dap.configurations.rust = {
--     {
--         name = "Launch file",
--         type = "codelldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--     }
-- }
--
-- -- Keymaps for debugging
-- vim.keymap.set('n', '<F5>', function() dap.continue() end)
-- vim.keymap.set('n', '<F6>', function() dap.terminate() end, { desc = "Debug: Stop" })
-- vim.keymap.set('n', '<F10>', function() dap.step_over() end)
-- vim.keymap.set('n', '<F11>', function() dap.step_into() end)
-- vim.keymap.set('n', '<F12>', function() dap.step_out() end)
-- vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() 
--     dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
-- end)
-- vim.keymap.set('n', '<Leader>lp', function() 
--     dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) 
-- end)
-- vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
--
--


-- Enhanced DAP Configuration
local ok_dap, dap = pcall(require, "dap")
local ok_dapui, dapui = pcall(require, "dapui")
if not (ok_dap and ok_dapui) then
  vim.notify("DAP plugins not ready (need nvim-dap + nvim-dap-ui + nvim-nio)", vim.log.levels.WARN)
  return
end

-- Enhanced DAP UI setup
dapui.setup({
  icons = { 
    expanded = "▾", 
    collapsed = "▸", 
    current_frame = "▶"
  },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = 'bottom',
    },
  },
  controls = {
    element = "repl",
    enabled = true,
    icons = {
      pause = "⏸",
      play = "▶",
      step_into = "⏎",
      step_over = "⏭",
      step_out = "⏮",
      step_back = "b",
      run_last = "▶▶",
      terminate = "⏹",
      disconnect = "⏏",
    },
  },
  floating = {
    max_height = 0.9,
    max_width = 0.5,
    border = "rounded",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
    max_value_lines = 100,
    indent = 1,
  }
})

-- Enhanced listeners
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
  vim.cmd('only')  -- Close splits, keep main window
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
  vim.cmd('only')
end

-- Better adapter configuration
local function get_delve_path()
  local paths = {
    vim.fn.exepath('dlv'),
    vim.fn.expand('~/.local/share/nvim/mason/bin/dlv'),
    vim.fn.expand('~/go/bin/dlv'),
  }
  
  for _, path in ipairs(paths) do
    if path and path ~= '' and vim.fn.executable(path) == 1 then
      return path
    end
  end
  return 'dlv'
end

dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = get_delve_path(),
    args = {'dap', '-l', '127.0.0.1:${port}'},
  },
  options = {
    initialize_timeout_sec = 20,
  }
}

-- Enhanced Go configurations
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug Package",
    request = "launch",
    program = "${workspaceFolder}",
  },
  {
    type = "delve",
    name = "Debug Current File",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug Test",
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug Test Package",
    request = "launch",
    mode = "test",
    program = "${workspaceFolder}"
  },
  {
    type = "delve",
    name = "Debug with Arguments",
    request = "launch",
    program = "${workspaceFolder}",
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      return vim.split(args_string, " +")
    end,
  },
  {
    type = "delve",
    name = "Debug with Env Vars",
    request = "launch",
    program = "${workspaceFolder}",
    env = {
      GO_ENV = "development",
      DEBUG = "true",
    },
  },
  {
    type = "delve",
    name = "Attach to Process",
    request = "attach",
    mode = "local",
    processId = function()
      return tonumber(vim.fn.input('Process ID: '))
    end,
  },
}

-- Visual indicators
vim.fn.sign_define('DapBreakpoint', {
  text = '🔴', 
  texthl = 'DapBreakpoint', 
  linehl = 'DapBreakpointLine', 
  numhl = 'DapBreakpoint'
})
vim.fn.sign_define('DapBreakpointCondition', {
  text = '🟡', 
  texthl = 'DapBreakpoint', 
  linehl = 'DapBreakpointLine', 
  numhl = 'DapBreakpoint'
})
vim.fn.sign_define('DapStopped', {
  text = '▶️', 
  texthl = 'DapStopped', 
  linehl = 'DapStoppedLine', 
  numhl = 'DapStopped'
})

-- Enhanced keymaps
local function start_debug()
  vim.cmd('wa')  -- Save all files
  require('dap').continue()
end

-- Basic debug controls
-- vim.keymap.set('n', '<F5>', start_debug, { desc = "Save and start debug" })
-- vim.keymap.set('n', '<F6>', function() 
--   require('dap').terminate()
--   require('dapui').close()
--   vim.cmd('only')
-- end, { desc = "Stop debug and close all" })
-- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = "Step over" })
-- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = "Step into" })
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = "Step out" })

-- Debug mode state
local debug_mode = false

-- Toggle debug mode keymaps
local function toggle_debug_mode()
  if debug_mode then
    -- Disable debug mode - restore normal Vim keys
    vim.keymap.del('n', 'c')
    vim.keymap.del('n', 'n') 
    vim.keymap.del('n', 'i')
    vim.keymap.del('n', 'o')
    vim.keymap.del('n', 'q')
    debug_mode = false
    print("Debug mode: OFF")
  else
    -- Enable debug mode - override keys
    vim.keymap.set('n', 'c', function() require('dap').continue() end, { desc = "Debug: Continue" })
    vim.keymap.set('n', 'n', function() require('dap').step_over() end, { desc = "Debug: Next" })
    vim.keymap.set('n', 'i', function() require('dap').step_into() end, { desc = "Debug: Step" })
    vim.keymap.set('n', 'o', function() require('dap').step_out() end, { desc = "Debug: Out" })
    vim.keymap.set('n', 'q', function() 
      require('dap').terminate()
      require('dapui').close()
      vim.cmd('only')
      toggle_debug_mode()  -- Auto turn off debug mode
    end, { desc = "Debug: Quit" })
    debug_mode = true
    print("Debug mode: ON")
  end
end

-- Key to toggle debug mode
vim.keymap.set('n', '<leader>dm', toggle_debug_mode, { desc = "Toggle debug mode keymaps" })

-- Start debugging (and auto-enable debug mode)
vim.keymap.set('n', '<leader>dd', function() 
  vim.cmd('wa')  -- Save all
  require('dap').continue()
  if not debug_mode then
    toggle_debug_mode()  -- Auto-enable debug mode
  end
end, { desc = "Debug: Start" })
-- Breakpoint management
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })
vim.keymap.set('n', '<Leader>bc', function() 
  require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
end, { desc = "Conditional breakpoint" })
vim.keymap.set('n', '<Leader>bl', function() 
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) 
end, { desc = "Log point" })
vim.keymap.set('n', '<Leader>br', function() 
  require('dap').clear_breakpoints() 
end, { desc = "Clear all breakpoints" })

-- Session management
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = "Run last" })
vim.keymap.set('n', '<Leader>ds', function() require('dap').session() end, { desc = "Show session" })

-- Variable inspection
vim.keymap.set('n', '<Leader>dh', function() 
  local widgets = require('dap.ui.widgets')
  local my_widget = widgets.hover()
  if my_widget then
    vim.api.nvim_buf_set_keymap(my_widget.buf, 'n', 'q', '<cmd>close<cr>', { silent = true })
    vim.api.nvim_buf_set_keymap(my_widget.buf, 'n', '<Esc>', '<cmd>close<cr>', { silent = true })
  end
end, { desc = "Hover variables" })

vim.keymap.set('n', '<Leader>de', function() 
  local widgets = require('dap.ui.widgets')
  local my_widget = widgets.centered_float(require('dap.ui.widgets').expression) 
  if my_widget then
    vim.api.nvim_buf_set_keymap(my_widget.buf, 'n', 'q', '<cmd>close<cr>', { silent = true })
    vim.api.nvim_buf_set_keymap(my_widget.buf, 'n', '<Esc>', '<cmd>close<cr>', { silent = true })
  end

end, { desc = "Evaluate expression" })

vim.keymap.set('v', '<Leader>de', function() 
  local widgets = require('dap.ui.widgets')
  local my_widget = widgets.centered_float(require('dap.ui.widgets').expression) 
  if my_widget then
    vim.api.nvim_buf_set_keymap(my_widget.buf, 'n', 'q', '<cmd>close<cr>', { silent = true })
    vim.api.nvim_buf_set_keymap(my_widget.buf, 'n', '<Esc>', '<cmd>close<cr>', { silent = true })
  end

end, { desc = "Evaluate selection" })

-- Floating windows
vim.keymap.set('n', '<Leader>df', function() 
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = "Show frames" })
vim.keymap.set('n', '<Leader>dv', function() 
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = "Show variables" })

-- Stack navigation
vim.keymap.set('n', '<Leader>dk', function() require('dap').up() end, { desc = "Go up in stack" })
vim.keymap.set('n', '<Leader>dj', function() require('dap').down() end, { desc = "Go down in stack" })

-- Quick toggle UI
vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end, { desc = "Toggle DAP UI" })



