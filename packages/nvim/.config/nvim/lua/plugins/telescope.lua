return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    opts = {
        defaults = {
            prompt_prefix = " 󰍉  ",
            selection_caret = " ➜ ",
            entry_prefix = "   ",
            layout_strategy = "horizontal",

            icon_separator = " ::",
        },
        pickers = {
            find_files = {
                icon_separator = " ::",
            },
            live_grep = {
                icon_separator = " ::",
            },
            buffers = {
                icon_separator = " ::"
            }
        },
    },
}
