return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local swiftpm = require("config.swiftpm")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.workspace.didChangeWatchedFiles = {
				dynamicRegistration = true,
			}

			local ok, blink = pcall(require, "blink.cmp")
			if ok then
				capabilities = blink.get_lsp_capabilities(capabilities)
			end

			vim.lsp.config("sourcekit", {
				cmd = { "xcrun", "sourcekit-lsp" },
				filetypes = { "swift" },
				root_dir = swiftpm.root,
				single_file_support = false,
				capabilities = capabilities,
				settings = {
					sourcekit = {
						formatting = {
							enabled = false,
						},
					},
				},
			})

			vim.lsp.enable("sourcekit")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
				callback = function(event)
					local opts = function(desc)
						return { buffer = event.buf, silent = true, desc = desc }
					end

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("LSP hover"))
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Find references"))
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
				end,
			})

			vim.diagnostic.config({
				virtual_text = {
					prefix = "*",
					spacing = 2,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "single",
					source = "if_many",
				},
			})
		end,
	},
}
