return true
		and {
			"folke/zen-mode.nvim",
			dependencies = {
				{
					"folke/twilight.nvim",
					opts = {
						dimming = {
							alpha = 0.25,
						},
					},
				},
			},
			config = function()
				local wk = require("which-key")
				wk.add({
					{
						"<leader>z",
						function()
							require("zen-mode").toggle({

								on_open = function(win)
									vim.b.miniindentscope_disable = true
								end,
								-- callback where you can add custom code when the Zen window closes
								on_close = function()
									vim.b.miniindentscope_disable = false
								end,
								window = {
									width = 0.7,
									backdrop = 1,
									options = {
										number = false,
										cursorline = false,
										wrap = true,
									},
								},
							})
						end,
						desc = "Toggle ZEN mode",
					},
				})
			end,
		}
	or {}
