return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 300,
			preset = "modern",
			spec = {
				{ "<leader>f", group = "find/format" },
				{ "<leader>g", group = "git" },
				{ "<leader>d", group = "diagnostics" },
				{ "<leader>o", desc = "Open project directory" },
				{ "<leader>r", group = "rename" },
			},
			icons = {
				mappings = false,
			},
			win = {
				border = "single",
			},
		},
	},
}
