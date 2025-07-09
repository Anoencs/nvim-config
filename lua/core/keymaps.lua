local keymap = vim.keymap.set

-- General mappings
keymap("i", "jj", "<Esc>")
keymap("n","<leader>e", ":Telescope diagnostics<CR>",{ noremap = true, silent = true })

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
vim.g.copilot_no_tab_map = true

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
-- leap
-- vim.keymap.set('n',        's', '<Plug>(leap)')
-- vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
-- vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
-- vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
--flash
vim.keymap.set({'n', 'x', 'o'}, 's', function() require("flash").jump() end)
vim.keymap.set({'n', 'x', 'o'}, 'S', function() require("flash").treesitter() end)
vim.keymap.set({'o'}, 'r', function() require("flash").remote() end)
vim.keymap.set({'o'}, 'R', function() require("flash").treesitter_search() end)

--List error
vim.keymap.set('n', '<leader>ce', function()
	local diagnostics = vim.diagnostic.get(0, {lnum = vim.fn.line(".") - 1})
	if #diagnostics > 0 then 
		local message = diagnostics[1].message
		vim.fn.setreg("+", message)
		print("Copied diagnostics: " .. message)
	else 
		print("No diagnostic at cursor")
	end
end, {noremap = true, silent = true})
vim.keymap.set('n', '<leader>ne',vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>pe',vim.diagnostic.goto_prev)

vim.keymap.set('n', 'gl', function()
    local word = vim.fn.expand('<cWORD>')
    
    -- Pattern to match URLs
    local url_pattern = 'https?://[%w-_%.%?%.:/%+=&%%]+'
    local url = string.match(word, url_pattern)
    
    if url then
        local cmd
        if vim.fn.has('mac') == 1 then
            cmd = 'open'
        elseif vim.fn.has('unix') == 1 then
            cmd = 'xdg-open'
        elseif vim.fn.has('win32') == 1 then
            cmd = 'start'
        else
            print("Unsupported OS")
            return
        end
        
        vim.fn.system({cmd, url})
        print("Opening: " .. url)
    else
        print("No URL found under cursor")
    end
end, { desc = "Open URL under cursor" })

-- virtual multi
vim.keymap.set('n', '<M-j>', function()
  vim.cmd('call vm#commands#add_cursor_down(0, v:count1)')
end, { desc = 'VM: Add cursor down' })

vim.keymap.set('n', '<M-k>', function()
  vim.cmd('call vm#commands#add_cursor_up(0, v:count1)')
end, { desc = 'VM: Add cursor up' })
