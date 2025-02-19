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
      "nvim-lua/plenary.nvim"
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
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },

    config = function()
      require("CopilotChat").setup({})
    end,
  })

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

  use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })

  use({
    "sotte/presenting.nvim",
    config = function()
      require("presenting").setup({
        options = {
          width = 240,
        },
      })
    end,
  })
  use({ "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })

  use({ "nvim-lua/lsp-status.nvim" })
  use({
    "jbyuki/venn.nvim",
    config = function()
      require("lib.plugin.venn")
    end,
  })
  use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" } })
  use({ "saadparwaiz1/cmp_luasnip" })

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("lib.plugin.cmp")
    end,
  })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })

  --

  use({ "nvim-lua/lsp_extensions.nvim" })
  use({ "airblade/vim-gitgutter" })

  use({ "kosayoda/nvim-lightbulb" })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("lib.plugin.treesitter")
    end,
  })

  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require("lib.plugin.telescope")
    end,
  })

  use({
    "feline-nvim/feline.nvim",
    config = function()
      require("lib.plugin.feline")
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  use({
    "p00f/godbolt.nvim",
    config = function()
      require("lib.plugin.godbolt")
    end,
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  use({
    "numToStr/FTerm.nvim",
    config = function()
      require("lib.plugin.fterm")
    end,
  })

  --use {
  --    "nvim-neorg/neorg",
  --    config = function()
  --        require('lib.plugin.neorg')
  --    end,
  --    requires = {"nvim-lua/plenary.nvim",   "folke/zen-mode.nvim"},

  --}

  --use({
  --  "NTBBloodbath/galaxyline.nvim",
  --  branch = "main",
  --  config = function()
  --    require("lib.plugin.statusline")
  --  end,
  --  requires = { "kyazdani42/nvim-web-devicons" },
  --})

  use({
    "romgrk/barbar.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  use({ "tpope/vim-fugitive" })
  use({ "vimwiki/vimwiki" })
  use({ "powerman/vim-plugin-AnsiEsc" })
  use({
    "junegunn/fzf",
    config = function()
      require("lib.plugin.fzf")
    end,
  })
  use({
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  })

  use({ "junegunn/fzf.vim" })

  use({ "morhetz/gruvbox" })
  use({ "simrat39/rust-tools.nvim" })

  use({ "rust-lang/rust.vim" })

  use({ "tjdevries/nlua.nvim" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("lib.plugin.dap")
    end,
  })
  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
  })
})
