return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				swift = { "swift_format" },
				lua = { "stylua" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end

				return {
					timeout_ms = 2000,
					lsp_format = "fallback",
				}
			end,
			formatters = {
				swift_format = {
					command = "swift-format",
					args = { "format", "--in-place", "$FILENAME" },
					stdin = false,
				},
			},
		},
	},
}
