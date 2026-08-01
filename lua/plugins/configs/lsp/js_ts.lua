local lspconfig = require('lspconfig')

-- Additional TypeScript server configuration
lspconfig.ts_ls.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      -- Additional TypeScript settings
      preferences = {
        quoteStyle = "single",
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
      suggest = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      preferences = {
        quoteStyle = "single",
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
      suggest = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
  },
  -- File types to activate this LSP
  filetypes = { 
    "javascript", 
    "javascriptreact", 
    "typescript", 
    "typescriptreact", 
    "vue" 
  },
  -- Additional initialization options
  init_options = {
    preferences = {
      disableSuggestions = false,
    },
  },
})

-- ESLint configuration
lspconfig.eslint.setup({
  settings = {
    workingDirectory = { mode = "auto" },
  },
  on_attach = function(client, bufnr)
    -- Enable ESLint fix on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- Optional: Configure inlay hints appearance
vim.api.nvim_set_hl(0, 'LspInlayHint', {
  fg = '#565f89',
  bg = 'NONE',
  italic = true,
})

-- Auto-enable inlay hints for JS/TS files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
  end,
})
