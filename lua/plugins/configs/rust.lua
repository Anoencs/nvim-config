local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local opts = {
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    },
    tools = {
        -- Auto setup inlay hints
        autoSetHints = true,
        -- Hover actions
        hover_actions = {
            auto_focus = false,
        },
        -- Debugging settings
        runnables = {
            use_telescope = true,
        },
        debuggables = {
            use_telescope = true,
        },
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            right_align = false,
            right_align_padding = 7,
        },
    },
    server = {
        standalone = true,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
                cargo = {
                    allFeatures = true,
                },
                completion = {
                    postfix = {
                        enable = false,
                    },
                },
            },
        },
    },
}

require('rust-tools').setup(opts)
