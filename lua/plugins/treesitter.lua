return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
      require("nvim-treesitter.install").compilers = { "gcc-12" }
			local config = require("nvim-treesitter.configs")

			--   vim.filetype.add({ extension = { mdx = "mdx" } })
			--   vim.treesitter.language.register("mdx", "markdown")

			vim.filetype.add({
				pattern = {
					[".*%.component%.html"] = "angular.html", -- Sets the filetype to `angular.html` if it matches the pattern
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "angular.html",
				callback = function()
					vim.treesitter.language.register("angular", "angular.html") -- Register the filetype with treesitter for the `angular` language/parser
				end,
			})

			config.setup({
				auto_install = true,
				ensure_installed = { "html", "lua", "javascript", "typescript", "vue" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
