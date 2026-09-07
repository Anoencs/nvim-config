local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.is_0_11 = vim.fn.has("nvim-0.11") == 1

function M.supports_method(client, method)
  if not client then
    return false
  end
  if type(client.supports_method) ~= "function" then
    return false
  end
  local ok, res = pcall(function()
    return client:supports_method(method)
  end)
  if ok then
    return res
  end
  ok, res = pcall(client.supports_method, client, method)
  return ok and res or false
end

local function refresh_codelens(bufnr)
  if vim.lsp.codelens.enable then
    pcall(vim.lsp.codelens.enable, true, { bufnr = bufnr })
    return
  end
  pcall(vim.lsp.codelens.refresh, { bufnr = bufnr })
end

function M.on_attach(client, bufnr)
  if not bufnr then
    return
  end

  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set({ "n", "x" }, "<F3>", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>lf", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)

  if M.is_0_11 then
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
  else
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end

  if vim.lsp.inlay_hint and M.supports_method(client, "textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  if M.supports_method(client, "textDocument/codeLens") then
    refresh_codelens(bufnr)
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("AnoLspCodelens" .. bufnr, { clear = true }),
      buffer = bufnr,
      callback = function()
        refresh_codelens(bufnr)
      end,
    })
  end

  local augroup = vim.api.nvim_create_augroup("AnoLspFormat" .. bufnr, { clear = true })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(c)
          return c.name ~= "ts_ls" and M.supports_method(c, "textDocument/formatting")
        end,
      })
    end,
  })
end

---Configure + enable a server on both 0.10 (lspconfig) and 0.11+ (vim.lsp.config)
---@param name string
---@param opts table|nil
function M.setup_server(name, opts)
  opts = opts or {}
  opts.capabilities = opts.capabilities or M.capabilities
  if not opts.on_attach then
    opts.on_attach = M.on_attach
  end

  if M.is_0_11 then
    -- on_attach handled globally via LspAttach in lsp/init.lua
    opts.on_attach = nil
    vim.lsp.config(name, opts)
    pcall(vim.lsp.enable, name)
  else
    local ok, lspconfig = pcall(require, "lspconfig")
    if ok and lspconfig[name] then
      lspconfig[name].setup(opts)
    end
  end
end

return M
