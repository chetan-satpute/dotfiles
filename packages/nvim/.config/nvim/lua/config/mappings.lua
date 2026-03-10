-- Conform
local conform = require("conform")

vim.keymap.set("n", "<leader>fm", conform.format)

-- LSP
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
-- stylua: ignore start
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
-- stylua: ignore end

-- Telescope
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", telescope.find_files)
vim.keymap.set("n", "<leader>lg", telescope.live_grep)

-- Copilot
-- vim.keymap.set("i", "<c-h>", "<Plug>(copilot-suggest)")

-- Custom
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<cr>")
vim.keymap.set("n", "<leader>gl", "<cmd>diffget //3<cr>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<cr>")

-- vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<cr>")
-- vim.keymap.set("n", "<leader>gl", "<cmd>diffget //3<cr>")
