return {
"metakirby5/codi.vim",
  config = function()
			local wk = require("which-key")

			wk.add({
				{ "<leader>ct", "<CMD>CodiNew javascript<CR>", desc = "Run codi ts runtime" },
			})
  end

}
