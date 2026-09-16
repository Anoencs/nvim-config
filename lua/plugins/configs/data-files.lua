local shared = require("plugins.configs.lsp.shared")

local has_schemastore, schemastore = pcall(require, "schemastore")

-- JSON: syntax errors + schema validation (package.json, tsconfig, etc.)
shared.setup_server("jsonls", {
  settings = {
    json = {
      schemas = has_schemastore and schemastore.json.schemas() or nil,
      validate = { enable = true },
    },
  },
})

-- YAML: syntax errors + schema validation (docker-compose, GH Actions, k8s...)
shared.setup_server("yamlls", {
  settings = {
    yaml = {
      schemaStore = {
        -- Disable the built-in store so SchemaStore.nvim's fuller catalog wins
        enable = false,
        url = "",
      },
      schemas = has_schemastore and schemastore.yaml.schemas() or nil,
      validate = true,
      keyOrdering = false, -- don't complain about key order
    },
  },
})

-- TOML
shared.setup_server("taplo")

-- CSV/TSV: no language server exists, so rainbow_csv provides column
-- highlighting plus :RainbowLint / :RainbowDelim and RBQL queries.
local ok_csv, rainbow = pcall(require, "rainbow_csv")
if ok_csv then
  rainbow.setup()
end

-- Neovim maps .csv already; add the neighbours it doesn't.
vim.filetype.add({
  extension = {
    tsv = "tsv",
    csv = "csv",
  },
})
