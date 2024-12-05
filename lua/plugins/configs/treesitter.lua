require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c", "lua", "vim", "go", 
        "javascript", "typescript", 
        "rust", "html", "prisma"
    },
    highlight = {
        enable = true,
    }
}
