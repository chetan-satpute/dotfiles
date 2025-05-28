local colors = require("kanagawa.colors").setup({ theme = "wave" })
local palette_colors = colors.palette
local theme_colors = colors.theme

local mode_colors = {
    n = palette_colors.dragonRed,
    no = palette_colors.dragonRed,
    cv = palette_colors.dragonRed,
    ce = palette_colors.dragonRed,
    ["!"] = palette_colors.dragonRed,
    t = palette_colors.dragonRed,
    i = palette_colors.dragonGreen,
    v = palette_colors.dragonBlue,
    [""] = palette_colors.dragonBlue,
    V = palette_colors.dragonBlue,
    c = palette_colors.dragonAqua,
    s = palette_colors.dragonOrange,
    S = palette_colors.dragonOrange,
    [""] = palette_colors.dragonOrange,
    ic = palette_colors.dragonYellow,
    R = palette_colors.dragonViolet,
    Rv = palette_colors.dragonViolet,
    r = palette_colors.dragonTeal,
    rm = palette_colors.dragonTeal,
    ["r?"] = palette_colors.dragonTeal,
}

local section_c = {
    {
        "mode",
        color = function()
            return { fg = mode_colors[vim.fn.mode()], gui = "bold" }
        end,
    },
    {
        "branch",
        color = { fg = palette_colors.dragonViolet },
    },
    {
        "diff",
        colored = true,
        diff_color = {
            added = { fg = theme_colors.vcs.added },
            modified = { fg = theme_colors.vcs.changed },
            removed = { fg = theme_colors.vcs.removed },
        },
    },
}

local section_x = {
    {
        "diagnostics",
        sources = { "nvim_lsp", "nvim_diagnostic" },
        diagnostics_color = {
            error = { fg = theme_colors.diag.error },
            warn = { fg = theme_colors.diag.warning },
            info = { fg = theme_colors.diag.info },
            hint = { fg = theme_colors.diag.hint },
        },
    },
    {
        "filename",
        path = 4,
        color = { fg = palette_colors.dragonViolet },
    },
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
            theme = { normal = { c = { bg = "none" } } },
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
