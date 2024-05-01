local theme = {
	FlashBackdrop = {fg = "#585b70" },
	flashmatch = {fg = "#f9e2af" },
	FlashCurrent = {fg = "#f38ba8" },
	FlashLabel = {fg = "#81c8be"},
}

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<CR>",
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
      vim.api.nvim_set_hl(0, k, v)
    end
	end,
}
