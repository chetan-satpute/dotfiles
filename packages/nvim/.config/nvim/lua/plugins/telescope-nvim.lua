return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = " 󰍉  ",
				selection_caret = " ➜ ",
				entry_prefix = "   ",
				layout_strategy = "horizontal",
			},
			pickers = {
				find_files = {
					icon_separator = "  ",
				},
				live_grep = {
					icon_separator = "  ",
				},
				buffers = {
					icon_separator = "  ",
				},
			},
			extensions = {
				fzf = {},
			},
		})

		require("telescope").load_extension("fzf")
	end,
}
