local predefined_lsp = {
  "lua_ls",
  "tsserver",
  "jsonls",
  "emmet_ls",
  "volar",
} -- Преднастроенные языки. Обязательно надо создать файл в папке lsp

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
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local wk = require('which-key')
      local a = 'qwe'
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, lsp in ipairs(predefined_lsp) do
        local cfg = require("lsp." .. lsp)
        cfg["capabilities"] = capabilities

        lspconfig[lsp].setup(cfg)
      end

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP: hover diagnostic" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: diagnostic PREV" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: diagnostic NEXT" })

      wk.register({
        L = {
          name = '+LSP',
          q = { vim.diagnostic.setloclist, "LSP: list of problems" },
          R = { '<CMD>LspRestart<CR>', 'Restart server' },
          w = {name = 'workspace+'}
        }
      }, { prefix = '<leader>' })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local function opts(o)
            o = o or {}
            o["buffer"] = ev.buf
            return o
          end

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts({ desc = "LSP: go to declaration" }))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts({ desc = "LSP: go to definition" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts({ desc = "LSP: hover info under cursor" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts({ desc = "LSP: go to implementation" }))
          vim.keymap.set(
            "n",
            "<leader>D",
            vim.lsp.buf.type_definition,
            opts({ desc = "LSP: type definition" })
          )

          vim.keymap.set("n", "<leader>Ls", vim.lsp.buf.signature_help, opts({ desc = "Signature help" }))
          vim.keymap.set(
            "n",
            "<leader>Lwa",
            vim.lsp.buf.add_workspace_folder,
            opts({ desc = "Add workspase folder" })
          )
          vim.keymap.set(
            "n",
            "<leader>Lwr",
            vim.lsp.buf.remove_workspace_folder,
            opts({ desc = "Remove workspase folder" })
          )
          vim.keymap.set("n", "<space>Lwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts({ desc = "Workspace list" }))
          vim.keymap.set("n", "<leader>Lr", vim.lsp.buf.rename, opts({ desc = "LSP: rename symbol" }))
          vim.keymap.set(
            { "n", "v" },
            "<leader>L<leader>",
            vim.lsp.buf.code_action,
            opts({ desc = "LSP: Code action" })
          )
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts({ desc = "LSP: References" }))
          vim.keymap.set("n", "<leader>cF", function()
            vim.lsp.buf.format({ async = true })
          end, opts({ desc = "LSP: Format" }))
        end,
      })
    end,
  },
}
