return {
    ts_ls = {},
    eslint = {},
    gopls = {},
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                diagnostics = {
                    globals = {
                        "vim",
                    },
                },
            },
        },
    },
    jsonls = {
        settings = {
            json = {
                schemas = {
                    {
                        fileMatch = { "package.json" },
                        url = "https://json.schemastore.org/package.json",
                    },
                    {
                        fileMatch = { "tsconfig*.json" },
                        url = "https://json.schemastore.org/tsconfig.json",
                    },
                    {
                        fileMatch = {
                            ".prettierrc",
                            ".prettierrc.json",
                            "prettier.config.json",
                        },
                        url = "https://json.schemastore.org/prettierrc.json",
                    },
                    {
                        fileMatch = { ".eslintrc", ".eslintrc.json" },
                        url = "https://json.schemastore.org/eslintrc.json",
                    },
                    {
                        fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                        url = "https://json.schemastore.org/babelrc.json",
                    },
                },
            },
        },
    },
    cssls = {
        settings = {
            css = {
                validate = true,
                lint = {
                    unknownAtRules = "ignore",
                },
                scss = { validate = true, lint = {
                    unknownAtRules = "ignore",
                } },
            },
        },
    },
}
