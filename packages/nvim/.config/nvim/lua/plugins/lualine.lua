-- local mode_colors = {
--     n = "#f7768e", -- red
--     no = "#f7768e",
--     cv = "#f7768e",
--     ce = "#f7768e",
--     ["!"] = "#f7768e",
--     t = "#f7768e",
--     i = "#9ece6a", -- green
--     v = "#7aa2f7", -- blue
--     [""] = "#7aa2f7",
--     V = "#7aa2f7",
--     c = "#7dcfff", -- cyan
--     s = "#ff9e64", -- orange
--     S = "#ff9e64",
--     [""] = "#ff9e64",
--     ic = "#e0af68", -- yellow
--     R = "#bb9af7", -- magenta/violet
--     Rv = "#bb9af7",
--     r = "#1abc9c", -- teal
--     rm = "#1abc9c",
--     ["r?"] = "#1abc9c",
-- }

local section_c = {
    -- {
    --     "mode",
    --     color = function()
    --         return { fg = mode_colors[vim.fn.mode()], gui = "bold" }
    --     end,
    -- },
    {
        "branch",
        color = { fg = "#bb9af7" }, -- violet
    },
    {
        "diff",
        colored = true,
        diff_color = {
            added = { fg = "#9ece6a" }, -- green
            modified = { fg = "#ff9e64" }, -- orange
            removed = { fg = "#f7768e" }, -- red
        },
    },
}

local section_x = {
    {
        "diagnostics",
        sources = { "nvim_lsp", "nvim_diagnostic" },
        diagnostics_color = {
            error = { fg = "#db4b4b" },
            warn = { fg = "#e0af68" },
            info = { fg = "#0db9d7" },
            hint = { fg = "#1abc9c" },
        },
    },
    {
        "filename",
        path = 4,
        color = { fg = "#bb9af7" },
    },
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = true,
    opts = {
        options = {
            always_divide_middle = true,
            component_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            globalstatus = true,
            icons_enabled = true,
            ignore_focus = {},
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
            section_separators = { left = "", right = "" },
            theme = { normal = { c = { bg = "#1a1b26" } } }, -- tokyonight.bg_dark
        },
        sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = section_c,
            lualine_x = section_x,
            lualine_y = {},
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
}
