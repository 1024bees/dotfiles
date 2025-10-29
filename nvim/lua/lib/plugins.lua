return require("lazy").setup({
  { "mzlogin/vim-markdown-toc" },

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

  { "ms-jpq/coq_nvim" },
  --{ "scrooloose/nerdtree", event = "VeryLazy" }, -- Converted 'on' to 'event'
  { "mhinz/vim-startify" },
  { "junegunn/limelight.vim" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lib.plugin.lspconfig")
    end,
  },

  { "aduros/ai.vim" },

  { "LnL7/vim-nix" },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({})
    end,
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        window = {
          split_ratio = 0.3, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
          position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "float", etc.
          enter_insert = true, -- Whether to enter insert mode when opening Claude Code
          hide_numbers = true, -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window
        },
      })
    end,
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
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000,
        },
        o3 = {
          endpoint = "https://api.openai.com",
          model = "o3",
          timeout = 30000,
        },
        o4_mini_high = {
          endpoint = "https://api.openai.com",
          model = "o4-mini-high",
          timeout = 30000,
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
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

  { "saadparwaiz1/cmp_luasnip" },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("lib.plugin.cmp")
    end,
  },

  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },

  { "nvim-lua/lsp_extensions.nvim" },
  { "airblade/vim-gitgutter" },

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
    "feline-nvim/feline.nvim",
    config = function()
      require("lib.plugin.feline")
    end,
    dependencies = { "kyazdani42/nvim-web-devicons" },
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
  { "simrat39/rust-tools.nvim" },

  { "rust-lang/rust.vim" },

  { "tjdevries/nlua.nvim" },
  { "nvimtools/none-ls.nvim" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },

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
