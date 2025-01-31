local theme = {
	FlashBackdrop = {fg = "#585b70" },
	flashmatch = {fg = "#f9e2af" },
	FlashCurrent = {fg = "#f38ba8" },
	FlashLabel = {fg = "#81c8be"},
}

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
    exclude = {
      "notify",
      "cmp_menu",
      "noice",
      "flash_prompt",
      "quick_fix",
      function(win)
        -- exclude non-focusable windows
        return not vim.api.nvim_win_get_config(win).focusable
      end,
    },
  },
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
      vim.api.nvim_set_hl(0, k, v)
    end

		local has_wk, wk = require("which-key")

    if not has_wk then
      return
    end
    
	end,
}
