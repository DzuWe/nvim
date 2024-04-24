local theme = {
	FlashBackdrop = "#585b70",
	FlashMatch = "#f9e2af",
	FlashCurrent = "#f38ba8",
	FlashLabel = "#cba6f7",
}

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
	config = function()
		require("flash").setup({})

    for k, v in pairs(theme) do
      vim.api.nvim_set_hl(0, k, { fg = v })
    end
	end,
}
