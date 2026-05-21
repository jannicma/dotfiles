return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,      -- load at startup
    priority = 1000,   -- make sure it loads before other UI plugins
    config = function()
      require("kanagawa").setup({
        theme = "wave", -- "wave" | "dragon" | "lotus"
        background = {
          dark = "wave",
          light = "lotus",
        },
      })

      -- Apply colorscheme
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
