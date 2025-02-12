return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local lualine_y = opts.sections.lualine_y
    lualine_y[#lualine_y + 1] = { "searchcount" }
  end,
}
