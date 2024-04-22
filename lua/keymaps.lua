local wk = require("which-key")

wk.register({
	c = {
		name = "+code actions",
		["="] = { "ggvG=<C-o>", "Indent all" },
		f = { vim.lsp.buf.format, "Format buffer" },
	},
}, { prefix = "<leader>" })
