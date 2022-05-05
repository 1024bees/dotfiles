local utils = require'lib.utils'
local create_augroups = utils.create_augroups
local autocmds = {
  load_core = {
    --{"VimEnter",        "*",      [[lua splashscreen()]]};
    --{"VimEnter",        "*",      [[nested lua require'tt.tools'.openQuickfix()]]};
    --{"SwapExists",      "*",      "call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)"};
    --{"TextYankPost",    "*",      [[silent! lua require'vim.highlight'.on_yank()]]};
    -- {"TermClose",       "*",      [[lua vim.api.nvim_input("i<esc>") ]]};
    {"VimEnter", "*", [[if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif]]};
    {"StdinReadPre", "*", "let s:std_in=1"};
    {"TermEnter",       "*",      "set nonumber"};
    {"BufWritePre",     "*",      [[if !isdirectory(expand("<afile>:p:h"))|call mkdir(expand("<afile>:p:h"), "p")|endif]]};

    --{"QuickFixCmdPost", "[^l]*",  [[nested lua require'tt.tools'.openQuickfix()]]};
    {"CursorHold,BufWritePost,BufReadPost,BufLeave", "*", [[if isdirectory(expand("<amatch>:h"))|let &swapfile = &modified|endif]]};
    -- { "FileType,BufWinEnter,BufReadPost,BufWritePost,BufEnter,WinEnter,FileChangedShellPost,VimResized" , "*", [[lua vim.wo.statusline = "%!SL()"]] };
    -- {"WinLeave", "*", [[lua vim.wo.statusline = "%f"]]};
    --{"CursorMoved",        "*",     [[lua require'tt.tools'.clearBlameVirtText()]]};
    --{"CursorMovedI",        "*",     [[lua require'tt.tools'.clearBlameVirtText()]]};
    {"FocusGained,CursorMoved,CursorMovedI", "*", "checktime"};
  };
  ft = {
    {"FileType lua inoremap <C-l> log()<esc>i"};
    {"FileType netrw nnoremap <buffer> q :close<CR>"};
    {"Filetype rust nnoremap <buffer> <Leader>r :Ferm cargo run<CR>"};
    --{"Filetype rust nnoremap <buffer> <Leader>f :term cargo build<CR>  "};
    {"Filetype rust nnoremap <buffer> <Leader>t :Ferm cargo test<CR>"};
    {"Filetype rust nnoremap <buffer> <Leader>u unimplemented!()<CR>"};
    {"Filetype python nnoremap <buffer> <Leader>r :Perm "};



  };
  windows = {
    {"WinEnter", "*", "set number"};
    {"WinLeave", "*", "set nonumber"};
  };
  bufs = {
    {"BufRead", "*", [[2match SpellBad /\v\s+$/]]};
    {"BufWritePost", "*", [[if getline(1) =~ "^#!.*/bin/" | silent execute "!chmod +x %" | endif"}]]};
    {"BufReadPost quickfix nnoremap <buffer><silent>ra :ReplaceAll<CR>"};
    {"BufReadPost quickfix nnoremap <buffer>rq :ReplaceQF"};
    {"BufReadPost quickfix nnoremap <buffer>R  :Cfilter!<space>"};
    {"BufReadPost quickfix nnoremap <buffer>K  :Cfilter<space>"};
    {"BufReadPost",         "*.fugitiveblame", "set ft=fugitiveblame"};
    {"InsertChange",         "*", "lua print(vim.fn.pumvisible())"};

    --{"CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost", "*rs", [[lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }]] }
  };
  ft_detect = {
    { "BufRead,BufNewFile",  "*.nginx", "set ft=nginx"};
    { "BufRead,BufNewFile", "nginx*.conf", "set ft=nginx"};
    { "BufRead,BufNewFile", "*nginx.conf","set ft=nginx"};
    { "BufRead,BufNewFile", "*/etc/nginx/*","set ft=nginx"};
    { "BufRead,BufNewFile", "*/usr/local/nginx/conf/*","set ft=nginx"};
    { "BufRead,BufNewFile", "*/nginx/*.conf","set ft=nginx"};
    { "BufNewFile,BufRead", "*.bat,*.sys", "set ft=dosbatch"};
    { "BufNewFile,BufRead", "*.mm,*.m", "set ft=objc"};
    { "BufNewFile,BufRead", "*.h,*.m,*.mm","set tags+=~/global-objc-tags"};
    { "BufNewFile,BufRead", "*.tsx", "setlocal commentstring=//%s"};
    { "BufNewFile,BufRead", "*.svelte", "setfiletype html"};
    { "BufNewFile,BufRead", "*.eslintrc,*.babelrc,*.prettierrc,*.huskyrc", "set ft=json"};
    { "BufNewFile,BufRead", "*.pcss", "set ft=css"};
    { "BufNewFile,BufRead", "*.wiki", "set ft=wiki"};
    { "BufRead,BufNewFile", "[Dd]ockerfile","set ft=Dockerfile"};
    { "BufRead,BufNewFile", "Dockerfile*","set ft=Dockerfile"};
    { "BufRead,BufNewFile", "[Dd]ockerfile.vim" ,"set ft=vim"};
    { "BufRead,BufNewFile", "*.dock", "set ft=Dockerfile"};
    { "BufRead,BufNewFile", "*.[Dd]ockerfile","set ft=Dockerfile"};
  };
}
create_augroups(autocmds)
