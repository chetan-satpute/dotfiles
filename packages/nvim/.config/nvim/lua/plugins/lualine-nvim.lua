local section_c = {
	{
		"branch",
		color = { fg = "#949CCC" }, -- indigo-300
	},
	{
		"diff",
		colored = true,
		diff_color = {
			added = { fg = "#5AC9BD" }, -- teal-400
			modified = { fg = "#DB9048" }, -- amber-400
			removed = { fg = "#CC5676" }, -- garnet-400
		},
	},
}

local section_x = {
	{
		"diagnostics",
		sources = { "nvim_lsp", "nvim_diagnostic" },
		diagnostics_color = {
			error = { fg = "#CC5676" }, -- garnet-400
			warn = { fg = "#D5BE8B" }, -- gold-300
			info = { fg = "#5D89C5" }, -- sapphire-400
			hint = { fg = "#5AC9BD" }, -- teal-400
		},
	},
	{
		"filename",
		path = 4,
		color = { fg = "#5D89C5" }, -- sapphire-400
	},
}

local transparent_theme = {
	normal = { c = { fg = "#C6C7D4", bg = "NONE" } },
	inactive = { c = { fg = "#8284A1", bg = "NONE" } },
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
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
			theme = transparent_theme,
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
