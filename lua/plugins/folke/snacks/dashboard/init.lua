return {
  enabled = true,
  preset = {
    header = require('plugins.folke.snacks.dashboard.pictures'),
    keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    }

  },
  sections = {
    {section = "header"},
    {section = "keys"}
  }
}
