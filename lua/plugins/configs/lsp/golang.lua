local shared = require("plugins.configs.lsp.shared")

require("plugins.configs.go")

shared.setup_server("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
        test = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
