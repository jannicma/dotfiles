return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = {
			install_dir = vim.fn.stdpath("data") .. "/site",
			parsers = {
				"swift",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"json",
				"yaml",
			},
		},
		config = function(_, opts)
			local treesitter = require("nvim-treesitter")
			treesitter.setup({
				install_dir = opts.install_dir,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user-treesitter-start", { clear = true }),
				pattern = opts.parsers,
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
