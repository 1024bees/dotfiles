local vim = vim
local api = vim.api

local M = {} 
local debounce_timers = {}
function M.create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command('augroup '..group_name)
		api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			-- if type(def) == 'table' and type(def[#def]) == 'function' then
			-- 	def[#def] = lua_callback(def[#def])
			-- end
			local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
			api.nvim_command(command)
		end
		api.nvim_command('augroup END')
	end
end





function M.keymap(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  return vim.api.nvim_set_keymap(mode, lhs, rhs, options)


  --return vim.api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, {
  --      nowait = true,
  --      silent = true,
  --      noremap = true,
  --  }))
end

function M.buf_keymap(buf, mode, lhs, rhs, opts)
  return vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, {
        nowait = true,
        silent = true,
        noremap = true,
    }))
end

function M.debounce(name, fn, time)
  if debounce_timers[name] then
    pcall(vim.loop.timer_stop, debounce_timers[name])
    debounce_timers[name] = nil
  end
  debounce_timers[name] = vim.defer_fn(function()
    fn()
    debounce_timers[name] = nil
  end, time or vim.o.updatetime)
end

function M.unmap(mode, lhs)
  return vim.api.nvim_del_keymap(mode, lhs)
end

function M.esc(cmd)
  return vim.api.nvim_replace_termcodes(cmd, true, false, true)
end

function M.opt(scope, key, value)
  vim[scope][key] = value
  if scope ~= 'o' then
  vim['o'][key] = value
  end
end


return M
