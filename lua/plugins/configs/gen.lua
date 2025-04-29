require('ollama').setup({
    model = 'deepseek-r1',
    url = 'http://localhost:11434',
})
vim.keymap.set({ 'n', 'v' }, '<leader>oo', ':<C-u>lua require("ollama").prompt()<CR>', { desc = 'Ollama Prompt Menu' })
vim.keymap.set({ 'n', 'v' }, '<leader>oe', ':<C-u>lua require("ollama").prompt("Explain_Code")<CR>', { desc = 'Ollama Explain' })
vim.keymap.set({ 'n', 'v' }, '<leader>og', ':<C-u>lua require("ollama").prompt("Generate_Code")<CR>', { desc = 'Ollama Generate' })
vim.keymap.set({ 'n', 'v' }, '<leader>om', ':<C-u>lua require("ollama").prompt("Modify_Code")<CR>', { desc = 'Ollama Modify' })

