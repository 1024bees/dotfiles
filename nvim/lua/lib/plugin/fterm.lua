-- Or you can do this

vim.cmd([[command! -nargs=* Ferm call luaeval("require('FTerm').scratch({cmd=_A})", [expand(<f-args>)])"]])

vim.cmd([[command! -nargs=* Perm call luaeval("require('FTerm').scratch({cmd=_A})", ['python', expand('%'), <f-args>])"]])


