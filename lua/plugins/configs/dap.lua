local dap = require('dap')
local dapui = require('dapui')

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
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
                'scopes',
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 10,
            position = 'bottom',
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
    }
})

-- Automatically open and close the DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = vim.fn.expand('~/.local/share/nvim/mason/bin/codelldb'),
        args = {'--port', '${port}'}
    }
}
dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = vim.fn.expand('~/.local/share/nvim/mason/bin/dlv'),
        args = {'dap', '-l', '127.0.0.1:${port}'},
    }
}


-- Configure debugger by language
-- For Golang
dap.configurations.go = {
    {
        type = "delve",
        name = "Debug Package",
        request = "launch",
        mode = "debug",
        program = "${workspaceFolder}",  -- This will debug the current package
    },
    {
        type = "delve",
        name = "Debug Current File",
        request = "launch",
        mode = "debug",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug Test",  -- Add configuration for debugging tests
        request = "launch",
        mode = "test",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug Test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}

-- For Rust
dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    }
}

-- Keymaps for debugging
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F6>', function() dap.terminate() end, { desc = "Debug: Stop" })
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() 
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
end)
vim.keymap.set('n', '<Leader>lp', function() 
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) 
end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
