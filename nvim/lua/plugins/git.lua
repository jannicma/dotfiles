return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"]h",
				function()
					require("gitsigns").nav_hunk("next")
				end,
				desc = "Next git hunk",
			},
			{
				"[h",
				function()
					require("gitsigns").nav_hunk("prev")
				end,
				desc = "Previous git hunk",
			},
			{
				"<leader>gp",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview git hunk",
			},
			{
				"<leader>gb",
				function()
					require("gitsigns").blame_line({ full = true })
				end,
				desc = "Blame line",
			},
		},
		opts = {
			current_line_blame = false,
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "^" },
				changedelete = { text = "~" },
				untracked = { text = "+" },
			},
		},
	},
}
