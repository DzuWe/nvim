return {
	"folke/noice.nvim",
	event = "VeryLazy",
	enabled = false,
	opts = {
		popupmenu = {
			enabled = false,
		},
		notify = {
			enabled = false,
		},
    messages = {
      enabled = true,
    },
		lsp = {
			signature = {
				enabled = false,
			},
		},

		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			long_message_to_split = false, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
}
