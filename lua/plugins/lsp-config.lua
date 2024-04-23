local predefined_lsp = { "lua_ls", "tsserver", "volar" } -- Преднастроенные языки. Обязательно надо создать файл в папке lsp

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local wk = require("which-key")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, lsp in ipairs(predefined_lsp) do
        local cfg = require("lsp." .. lsp)
        cfg["capabilities"] = capabilities

        lspconfig[lsp].setup(cfg)
      end

      wk.register({
        ["<leader>e"] = { vim.diagnostic.open_float, "LSP Diagnostic: expand" },
        ["<leader>q"] = { vim.diagnostic.setloclist, "LSP Diagnostic: loclist check what it mean))" },
        ["[d"] = { vim.diagnostic.goto_prev, "LSP Diagnostic: previous" },
        ["]d"] = { vim.diagnostic.goto_prev, "LSP Diagnostic: next" },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),

        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          wk.register({
            l = {
              name = "+LSP",
              D = { vim.lsp.buf.declaration, "LSP: go to declaration" },
              d = { vim.lsp.buf.definition, "LSP: go to definition" },
              h = { vim.lsp.buf.giver, "LSP: hover symbol" },
              i = { vim.lsp.buf.definition, "LSP: go to definition" },
            },
            ["<C-k>"] = { vim.lsp.buf.signature_help, 'LSP: Signature help', nowait = true },
          }, { prefix = '<leader>', buffer = ev.buf })
        end,
      })
    end,
  },
}
