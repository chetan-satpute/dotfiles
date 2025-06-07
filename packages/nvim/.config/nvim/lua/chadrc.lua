local M = {
    base46 = {
        theme = "tokyonight",
    },
    ui = {
        cmp = {
            icons_left = false, -- only for non-atom styles!
            style = "default", -- default/flat_light/flat_dark/atom/atom_colored
            abbr_maxwidth = 60,
            -- for tailwind, css lsp etc
            format_colors = { lsp = true, icon = "󱓻" },
        },

        telescope = { style = "borderless" }, -- borderless / bordered

        statusline = {
            enabled = false,
            theme = "vscode_colored",
        },

        tabufline = {
            enabled = false,
        },
    },
}

return M
