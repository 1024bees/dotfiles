local plugins = {}
local api = vim.api

local execute = vim.api.nvim_command
local fn = vim.fn

--local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
--o
--
--
--if fn.empty(fn.glob(install_path)) > 0 then
--  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
--  execute 'packadd packer.nvim'
--end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim" })

  use({ "mzlogin/vim-markdown-toc" })

  use({
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup()
    end,
  })

  use({ "ms-jpq/coq_nvim" })
  use({ "scrooloose/nerdtree", on = "NERDTreeToggle" })
  use({ "mhinz/vim-startify" })
  use({ "junegunn/limelight.vim" })

  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("lib.plugin.lspconfig")
    end,
  })

  use({ "aduros/ai.vim" })

  use({ "LnL7/vim-nix" })

  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  })

  use({
    "samjwill/nvim-unception",
    setup = function()
      vim.g.unception_delete_replaced_buffer = true
      --vim.g.unception_open_buffer_in_new_tab = true
      -- Optional settings go here!
      -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
    end,
  })
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "jay-babu/mason-null-ls.nvim",
    run = ":MasonUpdate", -- :MasonUpdate updates registry contents,
    config = function()
      require("lib.plugin.mason")
    end,
  })

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
end)
