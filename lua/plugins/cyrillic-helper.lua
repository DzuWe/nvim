return {
  "Wansmer/langmapper.nvim",
  enabled = true,
  lazy = false,
  priority = 1, -- High priority is needed if you will use `autoremap()`
  config = function()
    require("langmapper").setup({ --[[ your config ]]
    })
  end,
}
