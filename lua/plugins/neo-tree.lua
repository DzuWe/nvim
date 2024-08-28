return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	branch = "v3.x",
	config = function()
		local wk = require("which-key")
		require("neo-tree").setup({
			buffers = {
				follow_current_file = {
          enabled = true
        },
			},
		})

		wk.add({
			{ "<leader>n", group = "FileTree Navigation" },
			{ "<leader>ne", "<CMD>Neotree toggle<CR>", desc = "Toggle neo-tree" },
			{ "<leader>ng", "<CMD>Neotree git_status right toggle<CR>", desc = "Toggle git status" },
			{ "<leader>nb", "<CMD>Neotree buffers right toggle<CR>", desc = "Toggle buffers" },
		})

		vim.keymap.set("n", "<leader>nf", function()
			local reveal_file = vim.fn.expand("%:p")
			if reveal_file == "" then
				reveal_file = vim.fn.getcwd()
			else
				local f = io.open(reveal_file, "r")
				if f then
					f.close(f)
				else
					reveal_file = vim.fn.getcwd()
				end
			end
			require("neo-tree.command").execute({
				action = "focus", -- OPTIONAL, this is the default value
				source = "filesystem", -- OPTIONAL, this is the default value
				position = "left", -- OPTIONAL, this is the default value
				reveal_file = reveal_file, -- path to file or folder to reveal
				reveal_force_cwd = true, -- change cwd without asking if needed
			})
		end, { desc = "Open neo-tree at current file or working directory" })
	end,
}
