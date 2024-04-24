return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local b = null_ls.builtins

    null_ls.setup({
      sources = {
        b.formatting.stylua,
        b.formatting.prettier.with({
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("$HOME/.config/nvim/utils/prettier/.prettierrc.json"),
          },
        }),
      },
    })
  end,
}
