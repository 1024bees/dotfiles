
"
"
" ==============
"    VIM-PLUG
" ==============


" --- Auto Install, taken from vim-plug page

"if empty(glob('~/.config/nvim/plugged'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif




" --- Setup ---
"set nocompatible
filetype off




" --- Vim Plugins ---
call plug#begin('~/.config/nvim/vim-plug')
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }    "Filesystem navigator
    Plug 'mhinz/vim-startify'                       "Fancy vim startup
    Plug 'airblade/vim-gitgutter'                   "Shows diffs between previous commit in sidebar
    "Plug 'w0rp/ale'                                 "Style checker, trying over syntastic...
    Plug 'antoinemadec/vim-verilog-instance'        "For instatiating modules real quick in systemverilog
    Plug 'vhda/verilog_systemverilog.vim'           "Verilog syntax
    Plug 'junegunn/limelight.vim'                   "Highlights current text
    "Plug 'neoclide/coc.nvim', {'commit': 'ce448a6945d90609bc5c063577e12b859de0834b'  } "Autocomplete engine, basically.
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe' 

  " Extensions to built-in LSP, for example, providing type inlay hints
    Plug 'nvim-lua/lsp_extensions.nvim'

    Plug 'kosayoda/nvim-lightbulb'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    
    Plug 'tpope/vim-fugitive'
    Plug 'vimwiki/vimwiki'                          "Diary plugin
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }             "Fuzzy finder for vim
    Plug 'junegunn/fzf.vim'                             "Fuzzy finder for vim

    Plug 'vim-airline/vim-airline'                  "Status line, but better
    Plug 'vim-airline/vim-airline-themes'           "themes for above
    Plug 'octol/vim-cpp-enhanced-highlight'         "CPP highlight but better
    Plug 'morhetz/gruvbox'                          "Pretty colors
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
    Plug 'rust-lang/rust.vim'
" --- Plugins on trial ---
    Plug 'Shougo/denite.nvim'                       "Nice mappings
    Plug 'tpope/vim-surround'                       "shortcuts for surrounding strings and such
    Plug 'easymotion/vim-easymotion'                "Easier ... motion
    Plug 'jacoborus/tender.vim'                     "other colours
    Plug 'altercation/vim-colors-solarized'         "more colours
    Plug 'devjoe/vim-codequery'
    Plug 'mileszs/ack.vim'
    Plug 'Shougo/unite.vim'


call plug#end()


lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'
local lsp_extension = require'lsp_extensions'


require'lspconfig'.rust_analyzer.setup{}


-- Enable rust_analyzer

require('vim.lsp.diagnostic')._define_default_signs_and_highlights()

local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Enable type inlay hints
 

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  -- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
        

      augroup END
    ]], false)
  end
end

nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })


vim.cmd([[ autocmd ColorScheme * :lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights() ]]) 


require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  },
  highlight = {
    enable = true
  }
}



EOF


set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:true
let g:compe.source.treesitter = v:true
let g:compe.source.omni = v:true



autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif


map <C-n> :NERDTreeToggle<CR>
map <C-f> :FZF $ROOT<CR>
map <C-b> :vsp<CR> :silent! Startify<CR>
map <C-A> :silent! AnsiEsc<CR>
map cq :CodeQuery<CR>
"let g:airline#extensions#tabline#enabled = 1


" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction






" --- Enable Plugins ---
filetype indent plugin on




" ======================
"    GENERAL SETTINGS
" ======================
set history=50     " Save 50 command lines of history
set laststatus=2   " Always display status line

" --- Set <Leader> to Space ---
let mapleader="\<space>"
let g:mapleader="\<space>"


"nnoremap <Enter> :



" ====================
"    BEAUTIFICATION
" ====================
runtime ~/.config/nvim                  " Pointer to .vim directory
syntax on                       " Enable syntax highlighting
"set encoding=utf-8              " Set Vim character encoding to UTF-8
"set termencoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8            " Specify script character encoding to UTF-8
set guifont=consolas            " Favorite font
set termguicolors
silent! colorscheme gruvbox" Best color


" --- Display Settings ---
set number                      " Show numberlines
set showcmd
set showmatch
set incsearch                   " Incremental search
set ruler



" --- Indentation Settings ---
set tabstop=2                   "Tabs as 2 columns
set expandtab                   "Always spaces, never tabs
set autoindent                  "Autoindent
set shiftwidth=2
set smarttab
set softtabstop=2
"




" --- Indentation Shortcuts ---
" Press <Tab> in visual mode to indent
vnoremap <Tab> >gv
" Press <Shift-Tab> in visual mode to unindent
vnoremap <S-Tab> <gv
" <Tab> in normal mode to indent



" --- autocmd Group for All Files ---
augroup Generic


	" Highlight trailing whitespace
	autocmd BufRead * 2match SpellBad /\v\s+$/


	" Automatically remove trailing whitespace
	"autocmd BufWritePre * %s/\s\+$//e

	" Automatically add +x permissions
	autocmd BufWritePost * if getline(1) =~ "^#!.*/bin/" | silent execute "!chmod +x %" | endif
  autocmd BufRead call CloseNoNames
    " Automatically regen ctags on each buffer write
    " TODO: DISABLE THIS! This was just a little fun idea
    "autocmd BufWritePost * silent !udc
	" Disable syntax for large files
	"autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif

augroup END




" ==============
"    MOVEMENT
" ==============
imap kj <Esc>
imap jk <Esc>
noremap # ^
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
nnoremap <C-E> <C-W>_
nnoremap <C-e> <C-W>=
set hidden

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>



"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" closes current tab and all empty tabs 
function! CleanTabs()
  let [i, n; empty] = [1, bufnr('$')]
  while i <= n
    if bufexists(i) && bufname(i) == ''
      call add(empty, i)
    endif
    let i += 1
  endwhile
  if len(empty) > 0
    exe 'bwipeout!' join(empty)
  endif
endfunction



let g:airline_theme='gruvbox'



"TABLINE:
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline








"QOL --> Create 
inoremap {<CR> {<CR>}<C-o>O


highlight link CocErrorSign GruvboxRed
let g:python3_host_prog = '/usr/bin/python3'
tnoremap <Esc> <C-\><C-n>
" =======================
"    GENERAL SHORTCUTS
" =======================

"Backspace anything
set backspace=indent,eol,start

" --- Save/Quit Shortcuts ---
nnoremap <Leader>w :w!<Enter>
nnoremap <Leader>q :q!<Enter>
nnoremap <Leader>x :x!<Enter>
nnoremap <Leader>z :x!<Enter>
nnoremap <Leader>d :bd!<Enter>
nnoremap <Leader>n :bn<Enter>
nnoremap <Leader>m :bp<Enter>
"Paste from system clipboard
set clipboard+=unnamedplus
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
noremap <Leader>k  :GdbStartPDB python -m pdb %
nnoremap <Leader>g :let @*='b ' . expand('%:p') . ":" .line('.')<CR>


autocmd Filetype python nnoremap <buffer> <Leader>r :term python %<CR>

autocmd Filetype rust nnoremap <buffer> <Leader>r :term cargo run<CR>
autocmd Filetype rust nnoremap <buffer> <Leader>f :term cargo build<CR>
autocmd Filetype rust nnoremap <buffer> <Leader>t :term cargo test<CR>
autocmd Filetype rust nnoremap <buffer> <Leader>u iunimplemented!()<CR>
"autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"ChainingHint"} }

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
