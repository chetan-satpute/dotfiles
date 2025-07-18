-- https://github.com/NvChad/ui
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require("config.options")
require("config.lazy")
require("config.mappings")

-- load all highlights at once [https://github.com/NvChad/ui]
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end
