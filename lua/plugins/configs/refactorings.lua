local ok, refactoring = pcall(require, "refactoring")
if not ok then
  vim.notify("refactoring.nvim failed to load: " .. tostring(refactoring), vim.log.levels.WARN)
  return
end

refactoring.setup({
  prompt_func_return_type = {
    go = false,
    java = false,
    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  prompt_func_param_type = {
    go = false,
    java = false,
    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  printf_statements = {},
  print_var_statements = {},
  show_success_message = false,
})

vim.keymap.set("x", "<leader>re", function()
  require("refactoring").refactor("Extract Function")
end)
vim.keymap.set("x", "<leader>rf", function()
  require("refactoring").refactor("Extract Function To File")
end)
vim.keymap.set("x", "<leader>rv", function()
  require("refactoring").refactor("Extract Variable")
end)
vim.keymap.set("n", "<leader>rI", function()
  require("refactoring").refactor("Inline Function")
end)
vim.keymap.set({ "n", "x" }, "<leader>ri", function()
  require("refactoring").refactor("Inline Variable")
end)
vim.keymap.set("n", "<leader>rb", function()
  require("refactoring").refactor("Extract Block")
end)
vim.keymap.set("n", "<leader>rbf", function()
  require("refactoring").refactor("Extract Block To File")
end)

local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
  pcall(telescope.load_extension, "refactoring")
  vim.keymap.set({ "n", "x" }, "<leader>rr", function()
    require("telescope").extensions.refactoring.refactors()
  end)
end
