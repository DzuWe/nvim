local function all_trim(s)
	return s:match("^%s*(.*)"):match("(.-)%s*$")
end


return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "palenight",
			},
			sections = {
				lualine_c = {
					"filename",
				},
			},
		})
	end,
}
