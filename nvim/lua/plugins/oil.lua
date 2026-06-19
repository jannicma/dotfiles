return {
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{
				"-",
				function()
					require("oil").open()
				end,
				desc = "Open file directory",
			},
			{
				"<leader>o",
				function()
					require("oil").open(vim.uv.cwd())
				end,
				desc = "Open project directory",
			},
		},
		opts = {
			default_file_explorer = false,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = false,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name)
					return name == ".git" or name == ".DS_Store"
				end,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g?"] = "actions.show_help",
				["g."] = "actions.toggle_hidden",
				["q"] = "actions.close",
			},
			columns = {
				"permissions",
				"size",
				"mtime",
			},
		},
	},
}
