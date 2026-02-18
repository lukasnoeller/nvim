return {
  {
    "iruzo/matrix-nvim",
    lazy = false,    -- We want the theme to load immediately on startup
    priority = 1000, -- Make sure it loads before other plugins
    config = function()
      -- This is the command that actually activates the colorscheme
      vim.cmd([[colorscheme matrix]])
    end,
  },
}
