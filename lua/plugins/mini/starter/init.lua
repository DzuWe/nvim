local header = require("plugins.mini.starter.headers")

local stats = require("lazy").stats()

local text = string.format("\n\n⚡ Neovim loaded %d of %s plugins", stats.loaded, stats.count)

local footer = [[
⣿⣿⡆⠀⠀⢸⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⣾⣿⡆⠀
⣿⣿⡇⠀⠀⢸⣿⢰⣿⡆⠀⣾⣿⡆⠀⣾⣷ ⣿⣿⡇⠀⠀⣿⣿⡇⠀
⣿⣿⡇⠀⠀⢸⣿⠘⣿⣿⣤⣿⣿⣿⣤⣿⡇⢻⣿⡇⠀⠀⣿⣿⡇⠀
⣿⣿⡇⠀⠀⢸⡿⠀⢹⣿⣿⣿⣿⣿⣿⣿⠁⢸⣿⣇⠀⢀⣿⣿⠇⠀
⠙⢿⣷⣶⣶⡿⠁⠀⠈⣿⣿⠟⠀⣿⣿⠇⠀⠈⠻⣿⣶⣾⡿⠋⠀⠀
]]

local oil = require("oil")
 local org_roam =        require('org-roam')
local ORG_DIR = "~/orgfiles/"
local NVIM_DIR = "~/.config/nvim"
return {
  header = header,
  silent = true,
  query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.',
  items = {
    {
      name = "Daily note",
      action = function()
        org_roam.ext.dailies.goto_today()
      end,
      section = "Quick"
    },
    {
      action = function()
        vim.cmd("cd " .. NVIM_DIR)
        oil.open(NVIM_DIR)
      end,
      name = "NVIM config []",
      section = "Destinations",
    },
    {
      action = function()
        oil.open(ORG_DIR)
      end,
      name = "Orgfiles []",
      section = "Destinations",
    },
  },
  footer = footer .. text,
}
