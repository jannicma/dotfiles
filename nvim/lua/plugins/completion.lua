return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"saghen/blink.lib",
		},
		event = "InsertEnter",
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-y>"] = { "select_and_accept" },
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 250,
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				menu = {
					border = "single",
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "single",
				},
			},
			sources = {
				default = { "lsp", "path", "buffer" },
			},
			fuzzy = {
				implementation = "lua",
			},
		},
		opts_extend = { "sources.default" },
	},
}
