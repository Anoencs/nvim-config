-- Welcome message
print("Welcome Anoencs! How are you doing today?")
-- Add GOPATH/bin to Neovim's PATH
vim.env.PATH = vim.env.PATH .. ":" .. vim.env.HOME .. "/go/bin"
vim.opt.conceallevel = 1

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.pdf",
  callback = function()
    -- Find the last real file buffer
    local bufname = vim.fn.expand("%:p") -- Current buffer name
    if string.match(bufname, "NvimTree") then
      -- If the current buffer is NvimTree, find the last valid file buffer
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if name ~= "" and vim.bo[buf].buflisted then
          bufname = name -- Use the last real file buffer
          break
        end
      end
    end

    -- Debugging
    print("Opening file:", bufname)

    -- Ensure the file exists
    if vim.fn.filereadable(bufname) == 1 then
      vim.fn.jobstart({"zathura", bufname}, {detach = true}) -- Open Zathura
      vim.cmd("bd!") -- Close buffer
    else
      print("Error: File not found ->", bufname)
    end
  end,
})

require("core")

require("plugins")
