return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")

			-- Merge nvim-cmp LSP capabilities with Swift.org's watched-files capability
			local cmp_caps = require("cmp_nvim_lsp").default_capabilities()
			local swift_caps = {
				workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
			}
			local capabilities = vim.tbl_deep_extend("force", {}, cmp_caps, swift_caps)

			-- SourceKit-LSP configured for multi-package repos:
			-- - use xcrun to pick the active Xcode/Swift toolchain
			-- - root_dir = nearest Package.swift so each package gets its own LSP
			lspconfig.sourcekit.setup({
				cmd = { "xcrun", "sourcekit-lsp" },
				capabilities = capabilities,
				filetypes = { "swift", "objective-c", "objective-cpp" },
				single_file_support = false,
				root_dir = function(fname)
					return util.root_pattern("Package.swift")(fname) or util.find_git_ancestor(fname) or vim.loop.cwd()
				end,
			})

			-- Your existing on-attach keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function(args)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, noremap = true, silent = true })
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						{ buffer = args.buf, noremap = true, silent = true }
					)
				end,
			})

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- could be "●", "■", "▎"
					spacing = 2,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
