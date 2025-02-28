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
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        -- this config assumes you have OPENAI_API_KEY environment variable set
        openai_params = {
          -- NOTE: model can be a function returning the model name
          -- this is useful if you want to change the model on the fly
          -- using commands
          -- Example:
          -- model = function()
          --     if some_condition() then
          --         return "gpt-4-1106-preview"
          --     else
          --         return "gpt-3.5-turbo"
          --     end
          -- end,
          model = "gpt-4-1106-preview",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },
      })
    end,

    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({})
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
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "o3-mini", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
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
  { "jose-elias-alvarez/null-ls.nvim" },
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
