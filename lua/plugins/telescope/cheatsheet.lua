return {
  "doctorfree/cheatsheet.nvim",
  event = "VeryLazy",
  config = function()
    local ctactions = require("cheatsheet.telescope.actions")
    local wk = require("which-key")
    require("cheatsheet").setup({
      bundled_cheetsheets = {
        enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
        disabled = { "nerd-fonts" },
      },
      bundled_plugin_cheatsheets = {
        enabled = {
          "auto-session",
          "goto-preview",
          -- "octo.nvim",
          "telescope.nvim",
          "vim-easy-align",
          "vim-sandwich",
        },
        disabled = { "gitsigns" },
      },
      include_only_installed_plugins = true,
      telescope_mappings = {
        ["<CR>"] = ctactions.select_or_fill_commandline,
        ["<A-CR>"] = ctactions.select_or_execute,
        ["<C-S>"] = ctactions.copy_cheat_value,
        ["<C-E>"] = ctactions.edit_user_cheatsheet,
      },
    })
    wk.add {
      { '<leader>f?',  '<CMD>Cheatsheet<CR>', desc = 'Find in cheatsheets'}
    }
  end,
}
