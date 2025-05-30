local predefined_lsp = {
  "angularls",
  "dockerls",
  "html",
  "cssls",
  "lua_ls",
  "ts_ls",
  "jsonls",
  "emmet_language_server",
  "eslint",
  "vue_ls",
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
      local wk = require("which-key")
      for _, lsp in ipairs(predefined_lsp) do
        local status, cfg = pcall(require, "lsp." .. lsp)
        if not status then
          cfg = {}
        end
        vim.lsp.enable(lsp)
        vim.lsp.config(lsp, cfg)
      end

			wk.add({
				{ "[d", vim.diagnostic.goto_prev, desc = "LSP: diagnostic PREV" },
				{ "]d", vim.diagnostic.goto_next, desc = "LSP: diagnostic NEXT" },
				{ "<leader>e", vim.diagnostic.open_float, desc = "LSP: hover diagnostic" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>lR", "<CMD>LspRestart<CR>", desc = "Restart server" },
			})

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions

					wk.add({
						{ "gd", vim.lsp.buf.definition, desc = "LSP: go to definition" },
						{ "gD", vim.lsp.buf.type_definition, desc = "LSP: go to type definition" },
						{ "gr", vim.lsp.buf.references, desc = "LSP: go to references" },
						{ "K", vim.lsp.buf.hover, desc = "LSP: hover info under cursor" },
						{ "gi", vim.lsp.buf.implementation, desc = "LSP: go to implementation" },
						{ "<leader>D", vim.lsp.buf.type_definition, desc = "LSP: go to type definition" },
						{ "<leader>cF", vim.lsp.buf.format, desc = "LSP: format buffer" },
					})
					wk.add({
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
						{
							"<leader>lwa",
							vim.lsp.buf.add_workspace_folder,
							desc = "Add workspace folder",
							buffer = ev.buf,
						},
						{
							"<leader>lwr",
							vim.lsp.buf.remove_workspace_folder,
							desc = "Remove workspace folder",
							buffer = ev.buf,
						},
						{
							"<leader>lwl",
							function()
								print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
							end,
							desc = "List workspace folders",
							buffer = ev.buf,
						},
					})
				end,
			})
    end,
  },
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
        automatic_installation = true,
        ensure_installed = predefined_lsp,
      })
    end,
  },
}
