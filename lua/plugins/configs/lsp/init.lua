local shared = require("plugins.configs.lsp.shared")

-- Ensure Mason binaries (ts_ls, gopls, ...) are on PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

if vim.fn.has("nvim-0.11") == 1 then
  vim.o.winborder = "rounded"
end

vim.api.nvim_set_hl(0, "LspInlayHint", {
  fg = "#565f89",
  bg = "NONE",
  italic = true,
})

vim.diagnostic.config({
  virtual_text = { prefix = "●", source = "if_many" },
  float = { source = "if_many", border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

if shared.is_0_11 then
  vim.lsp.config("*", {
    capabilities = shared.capabilities,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("AnoLspAttach", { clear = true }),
    callback = function(args)
      shared.on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
    end,
  })
end

local default_servers = {
  "pylsp",
  "clangd",
  "emmet_language_server",
  "move_analyzer",
  "solidity_ls_nomicfoundation",
}

for _, server in ipairs(default_servers) do
  shared.setup_server(server)
end

require("plugins.configs.lsp.golang")
require("plugins.configs.lsp.rust")
require("plugins.configs.lsp.js_ts")
