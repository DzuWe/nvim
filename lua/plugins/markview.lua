return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  enabled = false,
  config = function()
    local mw = require("markview")
    local presets = require("markview.presets")
    mw.setup({
      typst = { enable = false },
      markdown = {
        headings = presets.headings.simple,
      },
    })
  end,
}
