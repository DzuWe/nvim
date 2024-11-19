local function getModule(name)
	return require("plugins.telescope." .. name)
end

return {
	getModule("cheatsheet"),
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local ts = require("telescope")
			local builtin = require("telescope.builtin")
			local wk = require("which-key")

			wk.add({
				{ "<leader>f", group = "fzf" },
				{ "<leader>ff", builtin.find_files, desc = "Find file" },
				{ "<leader>fg", builtin.live_grep, desc = "Find in files" },
				{ "<leader>fb", builtin.buffers, desc = "Find in buffers" },
				{ "<leader>fc", "<CMD>Telescope neoclip<CR>", desc = "clipboard" },
			})

			ts.setup({
				extentions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			ts.load_extension("ui-select")
		end,
	},
}
