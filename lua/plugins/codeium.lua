return {
	"Exafunction/codeium.vim",
	config = function()
		local wk = require("which-key")
    vim.g.codeium_disable_bindings = 1

		wk.register({
      ["<C-g>"] = {
        function()
          return vim.fn["codeium#Accept"]()
        end,
        "Codeium complete",
      },

      ["<C-x>"] = {
        function()
          return vim.fn["codeium#Clear"]()
        end,
        "Codeium clear",
      },
			["<C-.>"] = {
				function()
					return vim.fn["codeium#CycleCompletion"](1)
				end,
				"Cycle AI next",
			},
			["<C-,>"] = {
				function()
					return vim.fn["codeium#CycleCompletion"](-2)
				end,
				"Cycle AI previous",
			},
		}, { mode = "i", expr = true, silent = true })

    wk.register({
      A = {
        name = "+AI",
        a = { "<cmd>Codeium Enable<cr>", "Enable AI" },
        d = { "<cmd>Codeium Disable<cr>", "Disable AI" },
      }
      
    }, { prefix = "<leader>" })
	end,
}
