return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")

		vim.filetype.add({ extension = { mdx = "mdx" } })
    vim.treesitter.language.register('mdx', 'markdown')

		config.setup({
			auto_install = true,
			ensure_installed = { "lua", "javascript", "typescript", "vue" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
