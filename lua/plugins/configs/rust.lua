local shared = require("plugins.configs.lsp.shared")

shared.setup_server("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { allFeatures = true },
      completion = { postfix = { enable = false } },
    },
  },
})

-- Codelldb DAP via mason
local mason_codelldb = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension")
local codelldb_path = mason_codelldb .. "/adapter/codelldb"

if vim.fn.executable(codelldb_path) == 1 then
  local ok, dap = pcall(require, "dap")
  if ok then
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("AnoRustLsp", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "rust_analyzer" then
      return
    end
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = args.buf, silent = true })
  end,
})
