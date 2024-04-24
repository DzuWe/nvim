return {
  {
    "mg979/vim-visual-multi",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        '*'
      })
    end
  },
}
