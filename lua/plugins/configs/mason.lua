require("mason").setup({
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
})

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
  return
end

-- Mason installs binaries; servers are enabled via vim.lsp.config / lspconfig.
mason_lspconfig.setup({
  ensure_installed = {
    "gopls",
    "ts_ls",
    "eslint",
    "rust_analyzer",
    "pylsp",
    "clangd",
    "emmet_language_server",
  },
  automatic_enable = false,
})
