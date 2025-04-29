local M = {}

function M.setup()
    -- Check if pretty-fold is available
    local status_ok, pretty_fold = pcall(require, "pretty-fold")
    if not status_ok then
        vim.notify("pretty-fold not found!", vim.log.levels.WARN)
        return
    end

    -- Force enable folding globally (to override any settings that might disable it)
    vim.opt.foldenable = true
    
    -- Global pretty-fold configuration (ultra simplified for reliability)
    pretty_fold.setup({
        sections = {
            left = {'content'},
            right = {' ', 'number_of_folded_lines', ' lines'}
        },
        fill_char = '·',
    })

    -- Go-specific pretty-fold setup
    pretty_fold.ft_setup('go', {
        sections = {
            left = {'content'},
            right = {' ', 'number_of_folded_lines', ' lines'}
        },
        fill_char = '·',
    })

    -- DIRECT APPROACH: Create direct fold functions that don't rely on standard commands
    local function fold_all()
        -- Force foldmethod to a reliable method
        vim.opt.foldmethod = "indent"
        vim.opt.foldenable = true
        
        -- Directly manipulate fold levels without relying on zM
        for i = 1, vim.fn.line('$') do
            if vim.fn.foldlevel(i) > 0 then
                vim.fn.execute(i .. "foldclose")
            end
        end
        
        -- Refresh display
        vim.cmd("redraw")
    end
    
    local function unfold_all()
        vim.opt.foldenable = true
        
        -- Directly open all folds without relying on zR
        for i = 1, vim.fn.line('$') do
            if vim.fn.foldclosed(i) > 0 then
                vim.fn.execute(i .. "foldopen")
            end
        end
        
        -- Refresh display
        vim.cmd("redraw")
    end
    
    -- Register commands
    vim.api.nvim_create_user_command('FoldAll', fold_all, {})
    vim.api.nvim_create_user_command('UnfoldAll', unfold_all, {})
    
    -- Register direct keymaps that don't rely on standard fold commands
    vim.keymap.set('n', '<leader>fc', function() fold_all() end, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>fo', function() unfold_all() end, { noremap = true, silent = true })
    
    -- Create toggle fold function
    local function toggle_fold()
        local line = vim.fn.line('.')
        
        if vim.fn.foldclosed(line) > 0 then
            vim.fn.execute(line .. "foldopen")
        else
            vim.fn.execute(line .. "foldclose")
        end
    end
    
    -- Map toggle function
    vim.keymap.set('n', '<leader>ft', function() toggle_fold() end, { noremap = true, silent = true })
    
    -- Force every Go file to use indent folding (most reliable method)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
            -- Force indent method for reliability
            vim.opt_local.foldmethod = "indent"
            vim.opt_local.foldenable = true
            vim.opt_local.foldlevel = 99  -- Start with folds open
        end
    })
end

return M
