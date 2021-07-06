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

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end


function M.buffer_mapping()
  -- Get the names and buffer num of all currently open buffers
  local bufnr_to_name = {}
  for _, buffer in ipairs(vim.split(vim.fn.execute(':buffers! t'), "\n")) do
      local match = tonumber(string.match(buffer, '%s*(%d+)'))
      if match then
        local file_name = vim.api.nvim_buf_get_name(match)
        bufnr_to_name[match] = file_name
      end
  end
  return bufnr_to_name
end


function M.go_to_zsh()
  local buffers = M.buffer_mapping()
  for buffer_nr, _ in pairs(buffers) do
    if vim.fn.getbufvar(buffer_nr, "&buftype") == "terminal" then
      vim.fn.execute("buffer " .. buffer_nr)
      return
    end
  end
  vim.fn.execute("term zsh")
  M.go_to_zsh()
end


return M
