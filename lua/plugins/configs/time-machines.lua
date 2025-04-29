local M = {}

function M.setup()
    local status_ok, time_machine = pcall(require, "time-machine")
    if not status_ok then
        vim.notify("time-machine not found!", vim.log.levels.WARN)
        return
    end

    time_machine.setup({
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
end


vim.keymap.set('n', '<leader>tm', ':TimeMachineToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tb', ':TimeMachineBrowse<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>td', ':TimeMachineDiff<CR>', { noremap = true, silent = true })

return M


