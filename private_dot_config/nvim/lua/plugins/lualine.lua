return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, {
      function()
        return "󰙨 " .. vim.g.xcodebuild_test_plan
      end,
    })
    table.insert(opts.sections.lualine_x, {
      function()
        return " " .. vim.g.xcodebuild_device_name
      end,
    })
    table.insert(opts.sections.lualine_x, {
      function()
        return " " .. vim.g.xcodebuild_scheme
      end,
    })
  end,
}
