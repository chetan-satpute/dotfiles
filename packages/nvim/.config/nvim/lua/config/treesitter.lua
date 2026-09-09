vim.api.nvim_create_autocmd("FileType", {
	callback = function(event)
		local buf, filetype = event.buf, event.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then
			return
		end

		-- Enable syntax highlighting and other treesitter features
		pcall(vim.treesitter.start, buf)

		-- Enable treesitter based folds
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"

		-- Check if treesitter indentation is available for this language, and if so enable it
		-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
		local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

		-- Enable treesitter based indentation
		if has_indent_query then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
});
