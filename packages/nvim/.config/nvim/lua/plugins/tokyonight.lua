return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      on_highlights = function(hl, c)
        local prompt                  = "#2d3149"
        hl.TelescopeNormal            = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder            = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal      = {
          bg = prompt,
        }
        hl.TelescopePromptBorder      = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle       = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle      = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle      = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.StatusLine                 = { bg = "NONE" }
        hl.StatusLineNC               = { bg = "NONE" }
        hl.DiagnosticVirtualTextError = { fg = c.error, bg = "NONE" }
        hl.DiagnosticVirtualTextWarn  = { fg = c.warning, bg = "NONE" }
        hl.DiagnosticVirtualTextInfo  = { fg = c.info, bg = "NONE" }
        hl.DiagnosticVirtualTextHint  = { fg = c.hint, bg = "NONE" }
        hl.DiagnosticVirtualTextOk    = { fg = c.green1, bg = "NONE" }
      end,
    })

    vim.cmd([[colorscheme tokyonight-night]])
  end,
}
