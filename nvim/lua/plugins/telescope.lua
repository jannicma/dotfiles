return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({
						hidden = true,
						no_ignore = false,
						search_dirs = require("config.swiftpm").workspace_dirs(),
					})
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep({
						search_dirs = require("config.swiftpm").workspace_dirs(),
					})
				end,
				desc = "Live grep",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "Recent files",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Find LSP diagnostics",
			},
			{
				"<leader>fD",
				function()
					require("config.swift_build").run()
				end,
				desc = "Find build diagnostics",
			},
			{
				"<leader>gf",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Git files",
			},
		},
		opts = {
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "> ",
				path_display = { "truncate" },
				file_ignore_patterns = {
					"%.build/",
					"%.swiftpm/",
					"%.git/",
					"DerivedData/",
				},
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"fd",
						"--type",
						"f",
						"--hidden",
						"--exclude",
						".git",
						"--exclude",
						".build",
						"--exclude",
						".swiftpm",
					},
				},
			},
		},
	},
}
