local keymap = vim.keymap.set

-- General mappings
keymap("i", "jj", "<Esc>")

-- Tree
keymap("n", "<M-b>", ":NvimTreeToggle<CR>")
keymap("n", "<leader>w", ":NvimTreeFindFile<CR>")
keymap("n", "<leader>ge", ":GoIfErr<CR>")

-- Split screen and navigation
keymap("n", "<leader>v", ":vsplit<CR><C-w>l", { noremap = true })
keymap("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
keymap("n", "<leader>l", ":wincmd l<CR>", { noremap = true })
keymap("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
keymap("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
keymap("n", "<C-l>", "<C-LeftMouse>", {noremap = true})

-- Telescope mappings
keymap('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>f', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

keymap('i', '<M-m>', 'copilot#Accept("\\<CR>")', {
   expr = true,
   replace_keycodes = false
})

keymap('n', '<leader>p', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<M-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Tmux navigation
keymap("n", "C-h", ":TmuxNavigateLeft<CR>")
keymap("n", "C-l", ":TmuxNavigateRight<CR>")
keymap("n", "C-j", ":TmuxNavigateDown<CR>")
keymap("n", "C-k", ":TmuxNavigateUp<CR>")

-- LSP keymaps will be added by the LSP configuration
--
--
-- todo comments
--
vim.keymap.set('n', '<leader>tt', function()
    require('telescope').extensions['todo-comments'].todo({
        cwd = vim.fn.getcwd()
    })
end, { noremap = true, desc = "Search TODO comments in current project" })
keymap('n', '<leader>tdt', ':TodoTelescope keywords=TODO<CR>', {noremap = true})
keymap('n', '<leader>tdf', ':TodoTelescope keywords=FIX<CR>', {noremap = true})
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- goplements
keymap('n', '<leader>gi', ':GoplementsToggle<CR>', {noremap = true})
