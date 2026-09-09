return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
      go = { "gofmt" },
		},

		default_format_opts = {
			lsp_format = "fallback",
		},
	},
}
