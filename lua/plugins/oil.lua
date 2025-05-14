return {
	"stevearc/oil.nvim",
	config = function()
		local wk = require("which-key")
    local oil = require "oil"

		oil.setup({
			default_file_explorer = true,
      watch_for_changes = true,
		})

		wk.add({
      {"-", "<CMD>Oil<CR>", desc = "Open parrent directory"},
      {"<leader>ne", oil.toggle_float, desc = "Open float oil"}
		})
	end,
}
