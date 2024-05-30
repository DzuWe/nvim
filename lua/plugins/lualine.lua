local function all_trim(s)
	return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local function ai_status()
	local s = vim.api.nvim_call_function("codeium#GetStatusString", {})
	local icon_map = {
		["ON"] = "",
		["OFF"] = "󰫅",
		["*"] = "󱃲",
		["0"] = "󰋙",
	}

	return icon_map[all_trim(s)] or ("󰁘 " .. s)
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
					ai_status,
				},
			},
		})
	end,
}
