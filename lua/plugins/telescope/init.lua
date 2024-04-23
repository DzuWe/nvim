local function getModule(name)
  return require("lua.plugins.telescope." .. name)
end

return {
  getModule("cheatsheet"),
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local ts = require("telescope")
      local builtin = require("telescope.builtin")
      local wk = require("which-key")

      wk.register({
        ["<leader>"] = {
          f = {
            name = "+fzf",
            f = { builtin.find_files, "Find file" },
            g = { builtin.live_grep, "Find in files" },
            b = { builtin.buffers, "Find in buffers" },
          },
        },
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
  },
}
