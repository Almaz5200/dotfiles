return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        sourcekit = {},
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "disabled",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "json",
        "lua",
        "luap",
        "python",
        "tsx",
        "typescript",
        "swift",
      },
    },
  },
  {
    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "ojroques/nvim-osc52",
    event = "BufRead",
    config = function()
      require("osc52").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    command = "Oil",
    opts = {},
    -- Optional dependencies
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = false,
          ["<C-h>"] = false,
          ["<C-t>"] = false,
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = false,
          ["<C-lk"] = false,
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
      })
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = {
      useDefaultKeymaps = true,
      disabledKeymaps = { "n", "l", "in", "il", "an", "al" },
    },
  },
  {
    "sopa0/telescope-makefile",
    lazy = false,
    dependencies = {
      { "akinsho/toggleterm.nvim", version = "*", config = true },
    },
    config = function()
      require("telescope-makefile").setup({
        makefile_priority = { ".", "build/" },
        default_target = "default", -- nil or string : Name of the default target | nil will disable the default_target
      })
      require("telescope").load_extension("make")
    end,
  },
  {
    "tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "wellle/targets.vim",
    event = "BufRead",
  },
  {
    "folke/trouble.nvim",
    event = "BufRead",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {},
    config = function() end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    ft = { "swift", "rust" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    ft = { "rust", "swift" },
    config = function()
      require("config.dap")
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<C-A>",
          accept_word = false,
          accept_line = false,
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<M-]>",
        },
      },
      panel = { enabled = false },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   config = function()
      --     require("copilot_cmp").setup()
      --   end,
      -- },
      {
        "saecki/crates.nvim",
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "crates" })
      table.insert(opts.sources, { name = "copilot" })
      table.insert(opts.sources, { name = "orgmode" })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "./snippets" },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "mypy",
        "ruff",
        "black",
        "graphql-language-service-cli",
        "debugpy",
        "clangd",
        "clang-format",
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          cmd = "xcrun sourcekit-lsp",
        },
      },
    },
    config = function()
      require("config.lspconfig")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = { "python", "swift", "c", "go", "lua" },
    opts = function()
      return require("config.null-ls")
    end,
  },
}
