-- Keep undo history across sessions by storing it in a file
if os.execute("ls $HOME/.vim/undo-dir") ~= 0 then
  os.execute("mkdir -p $HOME/.vim/undo-dir -m=0770")
end
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


