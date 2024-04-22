return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")
					local wk = require("which-key")

					wk.register({
						h = {
							name = "+git signs",
							s = { gitsigns.stage_hunk, "Stage hunk" },
							r = { gitsigns.reset_hunk, "Reset hunk" },
							S = { gitsigns.stage_buffer, "Stage buffer" },
							u = { gitsigns.undo_stage_hunk, "Undo stage hunk" },
							R = { gitsigns.reset_buffer, "Reset buffer" },
							p = { gitsigns.preview_hunk, "Preview hunk" },
							b = {
								function()
									gitsigns.blame_line({ full = true })
								end,
								"Blame line",
							},
							d = { gitsigns.diffthis, "Preview diff this" },
						},
					}, { prefix = "<leader>", buffer = bufnr })
				end,
			})
		end,
	},
}
