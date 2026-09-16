local ok, conform = pcall(require, "conform")
if not ok then return end

-- Filetypes conform owns. shared.lua's LSP format-on-save skips these
-- (see M.conform_filetypes) so a buffer never gets formatted twice.
conform.setup({
  formatters_by_ft = {
    json = { "prettierd" },
    jsonc = { "prettierd" },
    json5 = { "prettierd" },
    yaml = { "prettierd" },
    toml = { "taplo" },
    markdown = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
  },
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 2000, lsp_format = "fallback" }
  end,
})

local map = vim.keymap.set

-- Format whole buffer / visual selection. Mirrors the <F3> you already use for LSP.
map({ "n", "x" }, "<leader>cf", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer/selection" })

-- Toggle autoformat when you must not touch a file's shape (e.g. a vendored config)
vim.api.nvim_create_user_command("FormatToggle", function(args)
  if args.bang then
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    vim.notify("Buffer autoformat: " .. (vim.b.disable_autoformat and "OFF" or "ON"))
  else
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    vim.notify("Global autoformat: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
  end
end, { bang = true, desc = "Toggle format-on-save (! = this buffer only)" })

-- :Format [formatter] on demand, e.g. :Format jq
vim.api.nvim_create_user_command("Format", function(args)
  conform.format({
    async = true,
    lsp_format = "fallback",
    formatters = args.args ~= "" and { args.args } or nil,
  })
end, { nargs = "?", desc = "Format buffer" })
