-- Keep undo history across sessions by storing it in a file
--if os.execute("ls $HOME/.vim/undo-dir") ~= 0 then
--  os.execute("mkdir -p $HOME/.vim/undo-dir -m=0770")
--end
-- Key remaps
local remap = vim.api.nvim_set_keymap
vim.g.mapleader = " "
local utils = require('lib.utils')

local fn = vim.fn

local packer_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_repo = 'https://github.com/wbthomason/packer.nvim'
local packer_install_cmd =
    '!git clone ' .. ' ' .. packer_repo .. ' ' .. packer_path

-- Install packer if missing as opt plugin
if fn.empty(fn.glob(packer_path)) > 0 then
  print("we are executing!")
  execute(packer_install_cmd)
  execute('packadd packer.nvim')
end




vim.api.nvim_exec([[
function! Get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction



function! Bazelify()
  let text = Get_visual_selection()
  let frags = split(text)
  let i=0
  while i < len(frags)
    let frags[i] = "\"" . frags[i] . "\""
    let i +=1
  endwhile
  let pstr = "[" . join(frags,", ") . "]"
  let @" = pstr
endfunction
]],
false)

utils.keymap('v', '<Leader>e', ':call Bazelify()<Enter>')






-- Rust
--Vim.g.rustfmt_autosave = 1
--Vim.g.rustfmt_command = "rustup +nightly rustfmt"
--Vim.g.rustfmt_recommended_style = 0
--Vim.g.mix_format_on_save = 1
require('lib.mappings2')
require('lib.autocmds')
require('lib.plugins')
vim.cmd('colorscheme gruvbox')
require('lib.settings')

require("luasnip.loaders.from_vscode").lazy_load()
