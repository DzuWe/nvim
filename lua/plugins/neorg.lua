return {
	"nvim-neorg/neorg",
	lazy = false,
	enable = false,
	version = "*",
	dependencies = {
		"vhyrro/luarocks.nvim",
	},
	config = function()
		local no = require("neorg")
		no.setup({
			load = {
				["core.defaults"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },
        ["core.integrations.nvim-cmp"] = {},
			},
		})
	end,
}
