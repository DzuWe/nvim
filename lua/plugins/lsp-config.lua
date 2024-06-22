local predefined_lsp = {
  "angularls",
  "cssls",
	"lua_ls",
	"tsserver",
	"jsonls",
	"emmet_language_server",
	"volar",
	"marksman",
	"graphql",
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
			local wk = require("which-key")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, lsp in ipairs(predefined_lsp) do
				local status, cfg = pcall(require, "lsp." .. lsp)

				if not status then
					cfg = {}
				end

				cfg["capabilities"] = capabilities

				lspconfig[lsp].setup(cfg)
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: diagnostic PREV" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: diagnostic NEXT" })

			wk.register({
				e = { vim.diagnostic.open_float, "LSP: hover diagnostic" },
				l = {
					name = "+LSP",
					q = { vim.diagnostic.setloclist, "LSP: list of problems" },
					R = { "<CMD>LspRestart<CR>", "Restart server" },
				},
			}, { prefix = "<leader>" })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions

					wk.register({
						gd = { vim.lsp.buf.definition, "LSP: go to definition" },
						gD = { vim.lsp.buf.type_definition, "LSP: go to type definition" },
						gr = { vim.lsp.buf.references, "LSP: go to references" },
						K = { vim.lsp.buf.hover, "LSP: hover info under cursor" },
						gi = { vim.lsp.buf.implementation, "LSP: go to implementation" },
						["<leader>D"] = { vim.lsp.buf.type_definition, "LSP: go to type definition" },
						["<leader>cF"] = { vim.lsp.buf.format, "LSP: format buffer" },
					})

					wk.register({
						d = { "<CMD>vertical split | lua vim.lsp.buf.definition()<CR>", "Open definition in side pane" },
						s = { vim.lsp.buf.signature_help, "Signature help" },
						r = { vim.lsp.buf.rename, "LSP: rename symbol" },
						w = {
							name = "+workspace",
							a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
							r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
							l = {
								function()
									print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
								end,
								"List workspace folders",
							},
						},
					}, {
						prefix = "<leader>l",
						buffer = ev.buf,
					})

					wk.register({
						["<leader><leader>"] = { vim.lsp.buf.code_action, "LSP: Code action" },
					}, { mode = { "n", "v" }, buffer = ev.buf })
				end,
			})
		end,
	},
}
