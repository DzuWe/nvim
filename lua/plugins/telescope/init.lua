local function get_module(name)
	return require("plugins.telescope." .. name)
end

return {
	get_module("cheatsheet"),
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
				{ "<leader>fh", function() builtin.find_files({ hidden = true }) end, desc = "Find file" },
				{ "<leader>fg", builtin.live_grep, desc = "Find in files" },
				{ "<leader>fb", builtin.buffers, desc = "Find in buffers" },
				{ "<leader>fc", builtin.commands, desc = "Find in user commands" },
				{ "<leader>fo", builtin.oldfiles, desc = "Find recent files" },
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
