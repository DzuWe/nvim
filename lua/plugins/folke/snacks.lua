local plugin_list = {
	"bigfile",
	"dashboard",
	"explorer",
	"indent",
	"input",
	"notifier",
	"picker",
	"quickfile",
	"scope",
	"scroll",
	"statuscolumn",
	"words",
  "zen",
}

local function get_configs()
	local opts = {}
	for _, name in ipairs(plugin_list) do
		local ok, cfg = pcall(require, "plugins.folke.snacks." .. name)
		if not ok then
			opts[name] = { enabled = false }
		else
			opts[name] = cfg
		end
	end
	return opts
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = get_configs()
}
