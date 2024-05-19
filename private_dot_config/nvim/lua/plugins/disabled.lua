return {
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  {
    "echasnovski/mini.pairs",
    config = {
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

        ['"'] = false,
        ["'"] = false,
        ["`"] = false,
      },
    },
  },
}
