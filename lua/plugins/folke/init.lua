local modules = {
	"noice",
	"trouble",
	"zen",
	"whichkey",
}

local function get_module(name)
	local ok, m = pcall(require, "plugins.folke." .. name)
	if not ok then
		return {}
	end
	return m
end

return true and vim.tbl_map(get_module, modules) or {}
