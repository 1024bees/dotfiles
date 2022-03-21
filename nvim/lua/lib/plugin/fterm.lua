-- Or you can do this

vim.cmd([[command! -nargs=* Ferm call luaeval("require('FTerm').scratch({cmd=_A})", [<f-args>])"]])



