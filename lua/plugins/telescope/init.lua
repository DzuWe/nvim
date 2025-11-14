local file_ignore_patterns = {
	"%.obsidian/*",
}

local function get_obsidian_root()
	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end
end

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
			"nvim-orgmode/telescope-orgmode.nvim",
		},
		config = function()
			local ts = require("telescope")
			local builtin = require("telescope.builtin")
			local wk = require("which-key")

			wk.add({
				{ "<leader>f", group = "fzf" },
				{
					"<leader>ff",
					function()
						builtin.find_files({
							file_ignore_patterns = file_ignore_patterns,
						})
					end,
					desc = "Find file",
				},
				{
					"<leader>fh",
					function()
						builtin.find_files({
							hidden = true,
							file_ignore_patterns = file_ignore_patterns,
						})
					end,
					desc = "Find file",
				},
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
