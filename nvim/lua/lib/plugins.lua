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

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use { 'wbthomason/packer.nvim'}

  use { 'scrooloose/nerdtree',  on='NERDTreeToggle' }
  use { 'mhinz/vim-startify' }




  use {'junegunn/limelight.vim' }

  use { 
    'neovim/nvim-lspconfig',
    config = function() require('lib.plugin.lspconfig') end,

  }

  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  use { 
    'hrsh7th/nvim-compe',
    config = function() require('lib.plugin.compe') end,
  }


  use { 'nvim-lua/lsp_extensions.nvim'}
  use { 'airblade/vim-gitgutter' }

  use { 'kosayoda/nvim-lightbulb'} 
  use { 
    'nvim-treesitter/nvim-treesitter',
    config = function() require('lib.plugin.treesitter') end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function() require('lib.plugin.telescope') end,
  }

  use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require 'lib.plugin.statusline' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }





  use { 'tpope/vim-fugitive' } 
  use { 'vimwiki/vimwiki' }
  use { 'powerman/vim-plugin-AnsiEsc' } 
  use {
    'junegunn/fzf',
    config = function() require('lib.plugin.fzf') end
  }
  use { 'junegunn/fzf.vim' }




  use { 'morhetz/gruvbox'}

  use { 'rust-lang/rust.vim' }

  use { 'tjdevries/nlua.nvim' }


end)
