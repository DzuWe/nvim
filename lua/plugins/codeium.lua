return {
	"Exafunction/codeium.vim",
	config = function()
		local wk = require("which-key")
		local ll = require("lualine")

		local function refresh_lualine(fn)
			ll.refresh({
				scope = "window",
				place = { "statusline" },
			})
			return fn
		end

		vim.g.codeium_disable_bindings = 1
    vim.g.codeium_filetypes_disabled_by_default = true

    vim.g.codeium_filetypes = {
      lua = true
    }

		wk.register({
			["<C-g>"] = {
				function()
					return refresh_lualine(vim.fn["codeium#Accept"]())
				end,
				"Codeium complete",
			},
			["<C-x>"] = {
				function()
					return refresh_lualine(vim.fn["codeium#Clear"]())
				end,
				"Codeium clear",
		},
			["<M-]>"] = {
				function()
					return refresh_lualine(vim.fn["codeium#CycleCompletions"](1))
				end,
				"Cycle AI next",
			},
			["<M-[>"] = {
				function()
					return refresh_lualine(vim.fn["codeium#CycleCompletions"](-1))
				end,
				"Cycle AI previous",
			},
		}, { mode = "i", expr = true, silent = true })

		wk.register({
			A = {
				name = "+AI",
				a = { "<cmd>Codeium Enable<cr>", "Enable AI" },
				d = { "<cmd>Codeium Disable<cr>", "Disable AI" },
			},
		}, { prefix = "<leader>" })
	end,
}
