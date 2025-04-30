local defaultUrl = "https://devx-copilot.tech"
local defaultModelName = "gpt-3.5-turbo"
local devxConfigDefaultPath = vim.fn.expand('$HOME/.continue/config.json')
local ok, config = pcall(vim.fn.readfile, devxConfigDefaultPath)

if not ok then
  return {}
end

config = vim.fn.join(config)
if type(config) == 'string' then
    config = vim.fn.json_decode(config)
end

return {
	{
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "devx-"..defaultModelName,
					},
          cmd = {
						adapter = "devx-"..defaultModelName,
          },
					inline = {
						adapter = "devx-"..defaultModelName,
					},
				},
        opts = {
          language = "Russian",
        },
				adapters = require('utils.ai-utils').createAdapters(config, defaultUrl),
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
