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
local VAULTS_DIR = "~/Obsidian/"
local NVIM_DIR = "~/.config/nvim"
return {
  header = header,
  silent = true,
  query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.',
  items = {
    {
      name = "Quick note",
      action = function()
        vim.cmd("")
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
        vim.cmd("cd " .. VAULTS_DIR)
        oil.open(VAULTS_DIR)
      end,
      name = "Obsidian Vaults []",
      section = "Destinations",
    },
  },
  footer = footer .. text,
}
