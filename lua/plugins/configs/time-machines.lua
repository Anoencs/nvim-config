require("time-machine").setup({
        auto_save = {
            enabled = true,           
            frequency = 30,          
            git_msg = "auto-saved",  
        },
        backup_dir = vim.fn.stdpath("data") .. "/time-machine", 
        diff = {
            cmd = "DiffviewOpen",   
        },
        delete_branch_after_restore = false,   
        keymaps = {
            next = "<C-n>", 
            prev = "<C-p>", 
        },
        message = {
            enabled = true,        
        },
        -- branch prefix
        branch_prefix = "timemachine", 

})


vim.keymap.set('n', '<leader>tm', ':TimeMachineToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tb', ':TimeMachineBrowse<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>td', ':TimeMachineDiff<CR>', { noremap = true, silent = true })
