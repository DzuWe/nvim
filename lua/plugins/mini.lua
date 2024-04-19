local mini_modules = { "surround", "notify", "starter" }

return {
	"echasnovski/mini.nvim",
	config = function()
		for _, m in ipairs(mini_modules) do
			require("mini." .. m).setup(require("external-cfg.mini." .. m))
		end
	end,
}
