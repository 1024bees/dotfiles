-- Make sure packer is installed before executing the rest of the script
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
else
  vim.cmd [[packadd packer.nvim]]-- Load package
end

require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    -- Packages
    use 'airblade/vim-gitgutter'
    use 'bronson/vim-trailing-whitespace'
    use 'cespare/vim-toml'
    use 'chriskempson/base16-vim'
    use 'editorconfig/editorconfig-vim'
    use 'elixir-editors/vim-elixir'
    use {'junegunn/fzf', hook='./install --all' }
    use 'mhinz/vim-mix-format'
    use 'rust-lang/rust.vim'
    use 'tbastos/vim-lua'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'vimwiki/vimwiki'                          --Diary plugin
    use 'jacoborus/tender.vim'                     --other colours
    use 'altercation/vim-colors-solarized'         --more colours
    use 'neovim/nvim-lspconfig'

end)

-- Instantiate LSP programs
require('lspconfig').rust_analyzer.setup{}

-- global
local o = vim.o
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.lcs = 'tab:/|/,space:·'
o.compatible = false
o.showmatch = true
o.smartcase = true
o.timeoutlen = 1000
o.ttimeoutlen = 0
o.undodir = '~/.vim/undo-dir'
o.undofile = true
o.laststatus = 2

-- window-local
local wo = vim.wo
wo.colorcolumn = '101'
wo.list = true
wo.number = true
wo.relativenumber = true
wo.wrap = true

-- buffer-local
local bo = vim.bo
bo.autoindent = true
bo.expandtab = true
bo.fileencoding = 'UTF-8'
bo.formatoptions = 'tcq'
bo.shiftwidth = 2
bo.smartindent = true
bo.softtabstop = 2
bo.syntax = 'on'
bo.tabstop = 2
bo.textwidth = 80

-- Colorscheme
vim.g.base16colorspace = 256
vim.cmd('colorscheme base16-default-dark')

vim.cmd('filetype plugin indent on')
vim.cmd('autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

-- Keep undo history across sessions by storing it in a file
if os.execute("ls $HOME/.vim/undo-dir") ~= 0 then
  os.execute("mkdir -p $HOME/.vim/undo-dir -m=0770")
end

-- Key remaps
local remap = vim.api.nvim_set_keymap
vim.g.mapleader = " "
-- Colemak Remaps
remap('n','<A-n>','<C-w>j', { silent = true })
remap('n','<A-e>','<C-w>k', { silent = true })
remap('n','<A-h>','<C-w>h', { silent = true })
remap('n','<A-i>','<C-w>l', { silent = true })
remap('n','<A-s>','<C-w>s', { silent = true })
remap('n','<A-v>','<C-w>v', { silent = true })
remap('n','<leader>i','i', { noremap = true })
remap('n','<leader>n','n', { noremap = true })
remap('n','<leader>o','o', { noremap = true })
remap('n','<leader>o',':', { silent = true, noremap = true })
remap('n','n','gj', { silent = true, noremap = true })
remap('n','e','gk', { silent = true, noremap = true })
remap('n','i','l', { silent = true, noremap = true })
remap('v','n','j', { silent = true, noremap = true })
remap('v','e','k', { silent = true, noremap = true })
remap('v','i','l', { silent = true, noremap = true })
remap('n','<leader><leader>','<ESC>', { noremap = true })
remap('v','<leader><leader>','<ESC>', { noremap = true })
remap('n',';',':', { silent = true, noremap = true })
remap('n','/','/\v', { silent = true, noremap = true })
remap('v','/','/\v', { silent = true, noremap = true })
remap('n','<leader><space>',':noh<cr>', { noremap = true })
remap('n','<tab>','%', { noremap = true })
remap('v','<tab>','%', { noremap = true })
remap('n','<leader>bn',':bnext<CR>', {})
remap('n','<leader>bd',':bdelete<CR>', {})
remap('n','<leader>bp',':bprevious<CR>', {})
-- Remove trailing whitespace
remap('n','<leader>rtws',':%s/\\s\\+$//e<CR>', {})
remap('n','<C-f>',':FZF<CR>', {})

-- Rust
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_command = "rustup +nightly rustfmt"
vim.g.rustfmt_recommended_style = 0
vim.g.mix_format_on_save = 1

-- vim-airline
local gset = vim.api.nvim_set_var
gset('airline#extensions#tabline#enabled', 1)
gset('airline#extensions#branch#enabled', 1)
gset('airline#extensions#branch#empty_message', '')
gset('airline#extensions#branch#use_vcscommand', 0)
gset('airline#extensions#branch#displayed_head_limit', 10)
gset('airline#extensions#branch#format', 0)
gset('airline#extensions#hunks#enabled', 1)
gset('airline#extensions#hunks#non_zero_only', 0)
gset('airline#extensions#hunks#hunk_symbols', "['+', '~', '-']")
gset('airline_powerline_fonts', 1)

-- FZF
vim.g.rg_command = [[
  rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  -g "!{.git,node_modules,vendor}/*"
]]
vim.cmd("command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)")
