---@diagnostic disable
local OBSIDIAN_PATH = vim.g.OBSIDIAN_PATH

local path = vim.loop.cwd() .. "/.obsidian"
local ok, err = vim.loop.fs_stat(path)

if not ok then
	return {}
end

local d = tostring(os.date("%A %B %Y"))
local date_tags = vim.split(d, " ", { plain = true })
local daily_tags = { "daily" }

for key, value in pairs(date_tags) do
	table.insert(daily_tags, string.lower(value))
end

return {
	"obsidian-nvim/obsidian.nvim",
	enabled = true,
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
	config = function()
		local obs = require("obsidian")
		local wk = require("which-key")
		local tcase = require("textcase")

		obs.setup({
			workspaces = {
				{
					name = "DzuMind",
					path = OBSIDIAN_PATH .. "DzuMind/",
				},
			},
			notes_subdir = "notes",
			daily_notes = {
				folder = "Notes/Daily",
				date_format = "%d-%m-%Y",
				alias_format = "%d %B %Y",
				default_tags = daily_tags,
				template = "Templates/Daily Template.md",
			},
			templates = {
				folder = "Templates",
				date_format = "%d-%m-%Y",
				time_format = "%H:%M",
			},
			completion = {
				blink = true,
			},
			-- way then set 'mappings = {}'.
			mappings = {
				["<leader><cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},
		})

		wk.add({
			{ "<leader>o", group = "Obsidian " },
			{
				"<leader>ot",
				function()
					local str = vim.fn.input("Input title tesis")
					local id = tcase.api.to_dash_case(tcase.api.to_lower_case(str))
					print("RAW: %s", str)
					print("ID: %s", id)
				end,
				mode = { "n", "v" },
				desc = "Create ",
			},
		})
	end,
}
