local has_config, secrets = pcall(require, 'secrets.mts-tokens')

if (not has_config) then
  return {}
end

if (secrets.gitlab == nil) then
  return {}
end

return {
	"harrisoncramer/gitlab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
		"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
	},
	build = function()
		require("gitlab.server").build(true)
	end,
	config = function()
    local wk = require("which-key")
    local gitlab = require("gitlab")

		gitlab.setup({
      auth_provider = function () return secrets.gitlab.token, secrets.gitlab.link , nil end
    })
    wk.add({
      {"<leader>g", group = "Gitlab actions"},
      {"<leader>gm", gitlab.choose_merge_request, desc = "Choose mr to review"}
    })
	end,
}
