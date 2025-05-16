return {
  "stevearc/oil.nvim",
  config = function()
    local wk = require("which-key")
    local oil = require("oil")
    local detail = false

    oil.setup({
      default_file_explorer = true,
      watch_for_changes = true,
      keymaps = {
        ["gr"] = "actions.refresh",
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              oil.set_columns({ "icon", "premission", "size", "mtime" })
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
      },
    })

    wk.add({
      { "-",          "<CMD>Oil<CR>",   desc = "Open parrent directory" },
      { "<leader>ne", oil.toggle_float, desc = "Open float oil" },
    })
  end,
}
