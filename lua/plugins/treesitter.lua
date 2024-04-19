return { 
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local config = require('nvim-treesitter.configs')
    config.setup({
      auto_install = true,
      ensure_installed = { 'lua', 'javascript', 'typescript', 'vue' },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}