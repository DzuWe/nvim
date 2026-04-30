return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = false,
        automatic_enable = {
          exclude = { "ts_ls" }
        },
        ensure_installed = { "lua_ls" }
      })
    end,
  },
}
