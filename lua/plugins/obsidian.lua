---@diagnostic disable
local OBSIDIAN_PATH = vim.g.OBSIDIAN_PATH
local d = tostring(os.date("%A %B %Y"))
local date_tags = vim.split(d, " ", { plain = true })
local daily_tags = {"daily"}

for key, value in pairs(date_tags) do
  table.insert(daily_tags, value)
end

return true
		and {
			"obsidian-nvim/obsidian.nvim",
			version = "*", -- recommended, use latest release instead of latest commit
			lazy = true,
			ft = "markdown",
			-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
			-- event = {
			--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
			--   -- refer to `:h file-pattern` for more examples
			--   "BufReadPre path/to/my-vault/*.md",
			--   "BufNewFile path/to/my-vault/*.md",
			-- },
			dependencies = {
				-- Required.
				"nvim-lua/plenary.nvim",

				-- see above for full list of optional dependencies ☝️
			},
			---@module 'obsidian'
			---@type obsidian.config.ClientOpts
			opts = {
				workspaces = {
					{
						name = "DzuMind",
						path = OBSIDIAN_PATH .. "DzuMind/",
					},
				},
				notes_subdir = "notes",
				daily_notes = {
					folder = "notes/dailies",
					date_format = "%d-%m-%Y",
					alias_format = "%d %B %Y",
					default_tags = daily_tags, 
				},
				completion = {
					blink = true,
				},
				-- way then set 'mappings = {}'.
				mappings = {
					-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- Toggle check-boxes.
					["<leader>ch"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
					-- Smart action depending on context: follow link, show notes with tag, toggle checkbox, or toggle heading fold
					["<cr>"] = {
						action = function()
							return require("obsidian").util.smart_action()
						end,
						opts = { buffer = true, expr = true },
					},
				},
			},
		}
	or {}
