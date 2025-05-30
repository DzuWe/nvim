local modules  = {
  "core",
  "org-roam"
}

local function get_module(name)
	local ok, m = pcall(require, "plugins.org." .. name)
	if not ok then
		return {}
	end
	return m
end

return vim.tbl_map(get_module, modules)
