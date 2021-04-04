local mappings = {}
local utils = require'lib/utils' 
-- Movement
utils.keymap('i', 'jk', '<Esc>')
utils.keymap('i', 'kj', '<Esc>')





utils.keymap('n', '#', '^')
utils.keymap('n', '<C-j>', '<C-W>j')
utils.keymap('n', '<C-k>', '<C-W>k')
utils.keymap('n', '<C-l>', '<C-W>l')
utils.keymap('n', '<C-h>', '<C-W>h')
utils.keymap('n', '<C-E>', '<C-W>_')
utils.keymap('n', '<C-e>', '<C-W>=')


-- Buffer managment
utils.keymap('n', '<Leader>w', ':w!<Enter>')
utils.keymap('n', '<Leader>q', ':q!<Enter>')
utils.keymap('n', '<Leader>x', ':x!<Enter>')
utils.keymap('n', '<Leader>z', ':x!<Enter>')
utils.keymap('n', '<Leader>d', ':bd!<Enter>')
utils.keymap('n', '<Leader>n', ':bn<Enter>')
utils.keymap('n', '<Leader>m', ':bp<Enter>')


utils.keymap('n', '<Leader>y', '"*y')
utils.keymap('n', '<Leader>p', '"*p')
utils.keymap('n', '<Leader>Y', '"+y')
utils.keymap('n', '<Leader>P', '"+p')
utils.keymap('n', '<Leader>g', [[:let @*='b ' . expand('%:p') . ":" .line('.')<CR>]])

--- Indentation Shortcuts ---
utils.keymap('v','<Tab>','>gv')
utils.keymap('v','<S-Tab>','<gv')



-- Popup management --how the fuck are you supposed to do this??? i dont care
--utils.keymap('i','<expr> <Tab>',[[pumvisible() ? "\<C-n>" : "\<Tab>"]],{expr = true})
--utils.keymap('i','<expr> <S-Tab>',[[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],{expr = true})

vim.cmd[[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]



-- Terminal remaps
utils.keymap('t','<Esc>', [[<C-\><C-n>]])
utils.keymap('n', '<C-f>', [[:FZF $ROOT<CR>]])
utils.keymap('n', '<C-b>', [[:silent! Startify<CR>]])


-- Plugin specific TODO: this should be moved to config files
--

