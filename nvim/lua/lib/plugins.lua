return require("lazy").setup({
  { "mzlogin/vim-markdown-toc" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      ---scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },

  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup()
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  -- { "ms-jpq/coq_nvim" },
  --{ "scrooloose/nerdtree", event = "VeryLazy" }, -- Converted 'on' to 'event'
  { "mhinz/vim-startify" },
  { "junegunn/limelight.vim" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lib.plugin.lspconfig")
    end,
  },
  -- Lazy
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {},
  },

  { "aduros/ai.vim" },

  { "LnL7/vim-nix" },

  {
    "yioneko/nvim-vtsls",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  {
    "samjwill/nvim-unception",
    init = function()
      vim.g.unception_delete_replaced_buffer = true
      --vim.g.unception_open_buffer_in_new_tab = true
      -- Optional settings go here!
      -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
    end,
  },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("lib.plugin.mason")
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "sotte/presenting.nvim",
    config = function()
      require("presenting").setup({
        options = {
          width = 240,
        },
      })
    end,
  },

  {
    "npxbr/gruvbox.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  { "nvim-lua/lsp-status.nvim" },

  {
    "jbyuki/venn.nvim",
    config = function()
      require("lib.plugin.venn")
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- { "saadparwaiz1/cmp_luasnip" },
  -- { "hrsh7th/nvim-cmp" },
  -- { "hrsh7th/cmp-nvim-lsp" },
  -- { "hrsh7th/cmp-buffer" },

  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("lib.plugin.blink")
    end,
  },

  { "nvim-lua/lsp_extensions.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  { "kosayoda/nvim-lightbulb" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("lib.plugin.treesitter")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("lib.plugin.telescope")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lib.plugin.lualine")
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "p00f/godbolt.nvim",
    config = function()
      require("lib.plugin.godbolt")
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },

  {
    "numToStr/FTerm.nvim",
    config = function()
      require("lib.plugin.fterm")
    end,
  },

  {
    "romgrk/barbar.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  { "tpope/vim-fugitive" },
  { "vimwiki/vimwiki" },
  { "powerman/vim-plugin-AnsiEsc" },

  {
    "junegunn/fzf",
    config = function()
      require("lib.plugin.fzf")
    end,
  },

  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  },

  { "junegunn/fzf.vim" },

  { "morhetz/gruvbox" },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<D-l>", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  { "rust-lang/rust.vim" },

  { "tjdevries/nlua.nvim" },
  { "nvimtools/none-ls.nvim" },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require("lib.plugin.dap")
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
  },
})
