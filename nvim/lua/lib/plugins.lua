local plugins = {}
local api = vim.api

local execute = vim.api.nvim_command
local fn = vim.fn

--local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
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

  use({ "mzlogin/vim-markdown-toc"})

  use({ "scrooloose/nerdtree", on = "NERDTreeToggle" })
  use({ "mhinz/vim-startify" })

  use({ "junegunn/limelight.vim" })

  use({ "sakhnik/nvim-gdb", run = ":!./install.sh" })

  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("lib.plugin.lspconfig")
    end
  })

  use({ "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })

  use({ "nvim-lua/lsp-status.nvim" })
  use({
    "jbyuki/venn.nvim",
    config = function()
      require("lib.plugin.venn")
    end,
  })
  use({ "L3MON4D3/LuaSnip",
    requires = {"rafamadriz/friendly-snippets"},
  })
  use({"saadparwaiz1/cmp_luasnip" })

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("lib.plugin.cmp")
    end,
  })
  use({'hrsh7th/cmp-nvim-lsp'})
  use({'hrsh7th/cmp-buffer'})

  
  --
    

 
  use({ "nvim-lua/lsp_extensions.nvim" })
  use({ "airblade/vim-gitgutter" })

  use({ "kosayoda/nvim-lightbulb" })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("lib.plugin.treesitter")
    end,
  })


  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require("lib.plugin.telescope")
    end,
  })


  use{
    "feline-nvim/feline.nvim",
    config = function()
      require("lib.plugin.feline")
    end,
    requires = { "kyazdani42/nvim-web-devicons" },

  }
  
  use {
    "p00f/godbolt.nvim",
    config = function()
      require("lib.plugin.godbolt")
    end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {"numToStr/FTerm.nvim",
    config = function() 
      require("lib.plugin.fterm")
    end,
  }

  use {
      "nvim-neorg/neorg",
      config = function()
          require('lib.plugin.neorg')
      end,
      requires = {"nvim-lua/plenary.nvim",   "folke/zen-mode.nvim"},

  }

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

  use({ "rust-lang/rust.vim" })

  use({ "tjdevries/nlua.nvim" })
  use({"jose-elias-alvarez/null-ls.nvim"})
  use({"jose-elias-alvarez/nvim-lsp-ts-utils"})


end)
