local file_ignore_patterns = {
}

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local ts = require("telescope")
    local builtin = require("telescope.builtin")
    local wk = require("which-key")

    wk.add({
      { "<leader>f",  group = "fzf" },
      {
        "<leader>ff",
        function()
          builtin.find_files({
            file_ignore_patterns = file_ignore_patterns,
          })
        end,
        desc = "Find file",
      },
      {
        "<leader>fh",
        function()
          builtin.find_files({
            hidden = true,
            file_ignore_patterns = file_ignore_patterns,
          })
        end,
        desc = "Find file",
      },
      { "<leader>fg", builtin.live_grep, desc = "Find in files" },
      { "<leader>fb", builtin.buffers,   desc = "Find in buffers" },
      { "<leader>fc", builtin.commands,  desc = "Find in user commands" },
      { "<leader>fo", builtin.oldfiles,  desc = "Find recent files" },
    })

    ts.setup({
      extentions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    ts.load_extension("ui-select")
  end,
}
