-- Function to get linter status
local function get_linter_status()
    return vim.g.go_linter_enabled and "Linter: ON" or "Linter: OFF"
end

require("lualine").setup{
    options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', get_linter_status},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
}
