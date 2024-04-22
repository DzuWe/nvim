local predefined_lsp = { 'lua_ls', 'tsserver', 'volar' } -- Преднастроенные языки. Обязательно надо создать файл в папке lsp
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
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for _, lsp in ipairs(predefined_lsp) do
        local cfg = require('lsp.' .. lsp)
        cfg['capabilities'] = capabilities

        lspconfig[lsp].setup(cfg)
      end

      wk.register({})

    end
  }
}
