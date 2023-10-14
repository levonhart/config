-- vim: foldmethod=marker
local M = {}

-- Treesitter configuration {{{
vim.defer_fn(function()
	---@diagnostic disable-next-line: missing-fields
	require('nvim-treesitter.configs').setup {
		ensure_installed = {
			'c', 'cpp', 'go', 'lua', 'python', 'rust', 'latex',
			'javascript', 'typescript', 'vimdoc', 'vim', 'cmake',
		},
		auto_install = false,
		highlight = { enable = true, disable = { 'latex' } },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<c-space>',
				node_incremental = '<c-space>',
				scope_incremental = '<c-s>',
				node_decremental = '<m-space>',
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		},
	}
end, 0)
-- }}} Treesitter configuration

-- Ltex External file {{{
M.ltex_dictionaries = function()
	---@diagnostic disable-next-line: lowercase-global
	insert = insert or table.insert
	local files = {}
	local find_dictfiles = function()
		local dictfiles = {}
		local dictdirs = vim.fs.find(function(name, _)
			return name:match('^%.vim$') or name:match('^%.vscode$') end,
			{ upward = true, stop = vim.loop.os_homedir(), type = 'directory',
				path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
		for _, dir in ipairs(dictdirs) do
			for fname, ftype in vim.fs.dir(dir) do
				if fname:match('ltex%.dictionary%.') and ftype:match('file') then
					insert(dictfiles, dir .. '/' .. fname)
				end
			end
		end
		return ipairs(dictfiles)
	end
	for _, file in find_dictfiles() do
		local _, _, lang = file:find('ltex%.dictionary%.([%-%a]+)%.txt$')
		files[lang] = files[lang] or {}
		local fullpath = vim.fs.normalize(file, ':p')
		insert(files[lang], ':' .. fullpath)
	end
	for _, file in ipairs(vim.api.nvim_get_runtime_file("spell/*.add", true)) do
		local lang = vim.fn.fnamemodify(file, ":t:r:r")
		files[lang] = files[lang] or {}
		local fullpath = vim.fn.fnamemodify(file, ":p")
		insert(files[lang], ':' .. fullpath)
	end
	if files.default then
		for lang, _ in pairs(files) do
			if lang ~= 'default' then
				vim.list_extend(files[lang], files.default)
			end
		end
		files.default = nil
	end
	return files
end
-- }}} Ltex External file

-- Comment Actions {{{
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
M.comment_linewise_visual = function(op)
	vim.api.nvim_feedkeys(esc, 'nx', false)
	op.linewise(vim.fn.visualmode())
end
M.comment_blockwise_visual = function(op)
	vim.api.nvim_feedkeys(esc, 'nx', false)
	op.blockwise(vim.fn.visualmode())
end
M.comment_move_count = function(api, cb)
	return vim.v.count == 0 and api.call(cb,'g@')
		or api.call(cb .. '.count', 'g@')
end
M.comment_current_count = function(op)
	if vim.v.count == 0 then op.current()
	else op.count(vim.v.count) end
end
-- }}} Comment Actions

-- Highlight utiliy {{{
M.vim_highlights = function(highlights)
    for group_name, group_settings in pairs(highlights) do
        vim.api.nvim_command(string.format('highlight %s guifg=%s guibg=%s guisp=%s gui=%s', group_name,
	            group_settings.fg or 'none',
	            group_settings.bg or 'none',
	            group_settings.sp or 'none',
	            group_settings.fmt or 'none'))
    end
end
-- }}} Highlight utiliy

return M
