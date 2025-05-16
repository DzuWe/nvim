return {
	filetypes = {
		"typescript", -- TypeScript files (.ts)
		"javascript", -- JavaScript files (.js)
		"javascriptreact", -- React files with JavaScript (.jsx)
		"typescriptreact", -- React files with TypeScript (.tsx)
		"vue", -- Vue.js single-file components (.vue)
	},
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fn.stdpath("data")
					.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
				languages = { "vue", "typescript", "javascript" },
			},
		},
	},
}
