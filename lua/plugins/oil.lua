return {
	"stevearc/oil.nvim",
	config = function()
		local wk = require("which-key")

		require("oil").setup({
			default_file_explorer = false,
		})

		wk.add({
      {"<leader>no",  "<CMD>Oil<CR>", desc = "Toggle Oil" },
		})
	end,
}
