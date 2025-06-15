local server_configs = require("config.lsp.server-configs")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local server_names = vim.tbl_keys(server_configs or {})

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(event)
                local opts = { buffer = event.buf }

                -- Show documentation for symbol under cursor
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                -- Go to definition
                vim.keymap.set("n", "gd", require('telescope.builtin').lsp_definitions, opts)

                -- Go to declaration (rarely used, but some prefer `gD`)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                -- Go to implementation(s)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

                -- Go to type definition (sometimes `gy` or `gt`)
                vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)

                -- List references
                vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)

                -- Signature help (often used in insert mode too)
                vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)

                -- Rename symbol
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                -- Code actions
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            end,
        })

        for _, server in ipairs(server_names) do
            vim.lsp.config[server] = server_configs[server]
            vim.lsp.config[server].capabilities = capabilities

            vim.lsp.enable(server)
        end
    end,
}
