return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      -- Choose your formatters per filetype
      formatters_by_ft = {
        swift = { "swift_format" }, -- see custom formatter below
        lua   = { "stylua" },
        -- add more: javascript = { "prettier" }, etc.
      },

      -- Format on save (sync, so errors show before write finishes)
      format_on_save = function(bufnr)
        -- Only enable if a formatter is available
        return { lsp_fallback = true, timeout_ms = 2000 }
      end,
    })

    -- Custom formatter definition for Apple's `swift-format` binary
    local conform = require("conform")
    conform.formatters.swift_format = {
      command = "swift-format",    -- make sure it's on PATH (brew install swift-format)
      args = { "--stdin" },        -- reads from stdin; add flags here if desired
      stdin = true,
    }

    -- Manual mapping to format the entire buffer
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ async = false, lsp_fallback = true })
    end, { desc = "Format buffer" })
  end,
}
