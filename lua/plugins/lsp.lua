local predefined_lsp = {
  "null-ls",
  "angularls",
  "dockerls",
  "html",
  "cssls",
  "lua_ls",
  "jsonls",
  "emmet_language_server",
  "eslint",
  "vue_ls",
  "vtsls",
  "marksman",
  "graphql",
} -- Преднастроенные языки. Обязательно надо создать файл в папке lsp


return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local wk = require('which-key')
      for _, lsp in ipairs(predefined_lsp) do
        local status, cfg = pcall(require, "lsp." .. lsp)
        if not status then
          cfg = {}
        end
        vim.lsp.enable(lsp)
        vim.lsp.config(lsp, cfg)
      end

      wk.add({
        { "<leader>e",  vim.diagnostic.open_float, desc = "LSP: hover diagnostic" },
        { "<leader>lR", "<CMD>lsp restart<CR>",    desc = "Restart server" },
      })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          MiniSnippets.start_lsp_server({ buffer = ev.buf })
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          --

          wk.add({
            { "gd",         vim.lsp.buf.definition,      desc = "LSP: go to definition" },
            { "gD",         vim.lsp.buf.type_definition, desc = "LSP: go to type definition" },
            { "gr",         vim.lsp.buf.references,      desc = "LSP: go to references" },
            { "K",          vim.lsp.buf.hover,           desc = "LSP: hover info under cursor" },
            { "gi",         vim.lsp.buf.implementation,  desc = "LSP: go to implementation" },
          })
          wk.add({
            { "<leader>lh", vim.diagnostic.get_prev, desc = "LSP: diagnostic PREV", buffer = ev.buf },
            { "<leader>ll", vim.diagnostic.get_next, desc = "LSP: diagnostic NEXT", buffer = ev.buf },
            {
              "<leader><leader>",
              vim.lsp.buf.code_action,
              desc = "LSP: Code action",
              mode = { "n", "v" },
              buffer = ev.buf,
            },
            {
              "<leader>ld",
              "<CMD>vertical split | lua vim.lsp.buf.definition()<CR>",
              desc = "Open definition in side pane",
              buffer = ev.buf,
            },
            {
              "<leader>ls",
              vim.lsp.buf.signature_help,
              desc = "Signature help",
              buffer = ev.buf,
            },
            {
              "<leader>lr",
              vim.lsp.buf.rename,
              desc = "LSP: rename symbol",
              buffer = ev.buf,
            },
            { "<leader>lw", group = "workspace" },
          })
        end,
      })
    end,
  },
}
