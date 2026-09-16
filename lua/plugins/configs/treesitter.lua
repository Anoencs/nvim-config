require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "go", "gomod", "gowork", "gosum",
        "javascript", "typescript", "tsx",
        "rust", "html", "css", "prisma",
        "json", "yaml", "toml", "bash", "diff",
        "markdown", "markdown_inline",
        "sql", "gotmpl", "comment",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<BS>",
        },
    },
})
