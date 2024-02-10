local o = vim.o --global
local wo = vim.wo --window
local bo = vim.bo --buffer
local cmd = vim.cmd

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end


-- buffer-local
local bo = vim.bo
bo.autoindent = true
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

vim.cmd('filetype plugin indent on')
vim.cmd('autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

-- Keep undo history across sessions by storing it in a file
--if os.execute("ls $HOME/.vim/undo-dir") ~= 0 then
--  os.execute("mkdir -p $HOME/.vim/undo-dir -m=0770")
--end





--global stuff, encoding etc
o.termguicolors = true
o.guifont = 'consolas'
o.termguicolors = true
o.showcmd = true
o.showmatch = true
o.ruler = true
o.ignorecase = true
o.completeopt="menuone,noselect"

o.hidden = true
o.shortmess = 'c'
o.signcolumn = 'yes'
o.updatetime = 500
o.history = 50
o.cmdheight = 2
o.clipboard='unnamedplus'

o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.lcs = 'tab:/|/,space:·'
o.compatible = false
o.showcmd = true
o.smartcase = true
o.timeoutlen = 1000
o.ttimeoutlen = 0  
o.undodir = os.getenv('HOME') .. '/.vim/undo-dir'
o.undofile = true
o.laststatus = 2
o.smarttab = true

-- Window stuff
wo.number = true
wo.wrap = false

--wo.colorcolumn = '101'
wo.list = true
wo.number = true
--wo.relativenumber = true
wo.wrap = true


--- Indentation Settings ---
--bo.tabstop = 2                   --Tabs as 2 columns
--bo.shiftwidth = 2
--bo.expandtab = true                  --Always spaces, never tabs
--bo.autoindent = true                  --Autoindent


--bo.softtabstop = 2
--bo.shiftwidth = 2

vim.g.vimwiki_global_ext = 0

bo.fileencoding= 'utf-8'
opt('b', 'shiftwidth', 2)
opt('b', 'tabstop', 2)
opt('b', 'softtabstop', 2)

opt('b', 'expandtab', true)
opt('b', 'autoindent', true)


vim.g.python3_host_prog = '/usr/bin/python3'

-- Colorscheme
vim.g.base16colorspace = 256

vim.cmd('filetype plugin indent on')
vim.cmd('autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')



