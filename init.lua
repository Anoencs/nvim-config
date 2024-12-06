-- Welcome message
print("Welcome Anoencs! How are you doing today?")
-- Add GOPATH/bin to Neovim's PATH
vim.env.PATH = vim.env.PATH .. ":" .. vim.env.HOME .. "/go/bin"
require("core")

require("plugins")
