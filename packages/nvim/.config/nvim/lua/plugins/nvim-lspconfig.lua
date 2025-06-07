local server_configs = require("config.lsp.server-configs")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local server_names = vim.tbl_keys(server_configs or {})

        for _, server in ipairs(server_names) do
            vim.lsp.config[server] = server_configs[server]
            vim.lsp.config[server].capabilities = capabilities

            vim.lsp.enable(server)
        end
    end,
}
