return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {
    style = "night",
    ---@param colors ColorScheme
    on_colors = function(colors)
      colors.bg_highlight = "#444a73"
    end,
  },
}
