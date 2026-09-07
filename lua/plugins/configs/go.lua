-- go.nvim: Go tooling only (if err, tags, tests). LSP is native vim.lsp in lsp/golang.lua.
local ok, go = pcall(require, "go")
if not ok then
  return
end

go.setup({
  disable_defaults = false,
  go = "go",
  goimports = "gopls",
  gofmt = "gopls",
  max_line_len = 0,
  tag_transform = false,
  tag_options = "json=omitempty",
  comment_placeholder = " 󰟓  ",
  icons = { breakpoint = "", currentpos = "" },
  verbose = false,
  lsp_cfg = false,
  lsp_gofumpt = true,
  lsp_on_attach = nil,
  lsp_keymaps = false,
  lsp_codelens = false,
  lsp_document_formatting = false,
  lsp_inlay_hints = { enable = false },
  gopls_remote_auto = true,
  dap_debug = false,
  dap_debug_keymap = false,
  dap_debug_gui = false,
  dap_debug_vt = false,
  textobjects = false,
  test_runner = "go",
  verbose_tests = true,
  luasnip = false,
})
