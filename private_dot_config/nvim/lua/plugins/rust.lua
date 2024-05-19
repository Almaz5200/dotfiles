return {
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    setup = function()
      require("config.rust")
    end,
  },
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    opts = {
      src = {
        cmp = {
          enabled = true,
        },
      },
    },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
}
