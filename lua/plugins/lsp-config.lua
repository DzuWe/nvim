local predefined_lsp = { 'lua_ls', 'tsserver' } -- Преднастроенные языки. Обязательно надо создать файл в папке lsp
return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = predefined_lsp
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local wk = require('which-key')

      for _, lsp in ipairs(predefined_lsp) do
        lspconfig[lsp].setup(require('lsp.' .. lsp))
      end

      wk.register({})

    end
  }
}
