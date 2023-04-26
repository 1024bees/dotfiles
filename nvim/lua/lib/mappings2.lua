local mappings = {}
local utils = require("lib/utils")
-- Movement
utils.keymap("i", "jk", "<Esc>")
utils.keymap("i", "kj", "<Esc>")

utils.keymap("n", "#", "^")
utils.keymap("n", "<C-j>", "<C-W>j")
utils.keymap("n", "<C-k>", "<C-W>k")
utils.keymap("n", "<C-l>", "<C-W>l")
utils.keymap("n", "<C-h>", "<C-W>h")
utils.keymap("n", "<C-E>", "<C-W>_")
utils.keymap("n", "<C-e>", "<C-W>=")

-- Buffer managment
utils.keymap("n", "<Leader>w", ":w!<Enter>")
utils.keymap("n", "<Leader>q", ":q!<Enter>")
utils.keymap("n", "<Leader>x", ":x!<Enter>")
utils.keymap("n", "<Leader>z", ":x!<Enter>")
utils.keymap("n", "<Leader>d", ":bd!<Enter>")
utils.keymap("n", "<Leader>n", ":bn<Enter>")
utils.keymap("n", "<Leader>m", ":bp<Enter>")

--utils.keymap('n', '<Leader>y', '"*y')
--utils.keymap('n', '<Leader>p', '"*p')
utils.keymap("n", "<Leader>y", '""y')
utils.keymap("n", "<Leader>p", '""p')
utils.keymap("n", "gt", [[:lua require'lib.utils'.go_to_zsh()<CR>]])

--- Indentation Shortcuts ---
utils.keymap("v", "<Tab>", ">gv")
utils.keymap("v", "<S-Tab>", "<gv")
utils.keymap("v", "<Tab>", ">gv")

-- Debugging
utils.keymap("n", "<Leader>g", ":lua require('dap').toggle_breakpoint()<CR>")
utils.keymap("n", "<F1>", ":lua require('dap').step_over()<CR>")
utils.keymap("n", "<F2>", ":lua require('dap').step_into()<CR>")
utils.keymap("n", "<F3>", ":lua require('dap').step_out()<CR>")

utils.keymap("n", "<Leader>dn", ":lua require('dap').step_over()<CR>")
utils.keymap("n", "<Leader>ds", ":lua require('dap').step_into()<CR>")
utils.keymap("n", "<Leader>do", ":lua require('dap').step_out()<CR>")



utils.keymap("n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>")
utils.keymap("v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")

utils.keymap("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
utils.keymap(
  "n",
  "<Leader>duf",
  ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>"
)

utils.keymap("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>")
utils.keymap("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")

utils.keymap("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

utils.keymap("n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")

utils.keymap("n", "<Leader>dc", ":lua require('dap').continue()<CR>")
utils.keymap("n", "<Leader>dx", ":lua require('dap').close()<CR>")
utils.keymap("n", "<Leader>di", ":lua require('dapui').toggle()<CR>")
utils.keymap("n", "<Leader>dd", ":lua require('dap').down()<CR>")
utils.keymap("n", "<Leader>du", ":lua require('dap').up()<CR>")
utils.keymap("n", "<Leader>dp", ":lua require('dapui').setup()<CR>")




-- Popup management --how the fuck are you supposed to do this??? i dont care
--utils.keymap('i','<expr> <Tab>',[[pumvisible() ? "\<C-n>" : "\<Tab>"]],{expr = true})
--utils.keymap('i','<expr> <S-Tab>',[[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],{expr = true})

--vim.cmd[[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
--vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]

-- Terminal remaps
utils.keymap("t", "<Esc>", [[<C-\><C-n>]])
utils.keymap("n", "<C-b>", [[:silent! Startify<CR>]])

-- Plugin specific TODO: this should be moved to config files
--
