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

-- Find Root {{{
---@diagnostic disable-next-line: lowercase-global
function find_root(bufnr)
	bufnr = bufnr or 0
	return vim.fs.root(bufnr, { '.git', '.hg', '.latexmkrc', '.ltex' })
		or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:h')
end
-- }}} Find Root

-- Ltex External file {{{
local lsputil = require('lspconfig.util')

M.ltex_find = function()
	local root = find_root()
	local wdir = nil
	if root ~= nil then
		vscode = vim.uv.fs_stat(root .. '/.vscode')
		if vscode ~= nil and vscode.type == 'directory' and next(vim.fs.find(function(name, path)
				return name:match('ltex%..*%.txt') and path:match('[/\\]%.vscode$')
			end, {limite = 1, type = 'file'})) then
			wdir = root .. '/.vscode'
		else
			wdir = root .. '/.ltex'
		end
	end
	vim.notify('ltex Working Directory:\t' .. (wdir or ''), vim.log.levels.INFO)
	return wdir or ''
end

---@diagnostic disable-next-line: lowercase-global
insert = insert or table.insert
M.ltex_wdirs = nil
local ltex_getwdirs = function()
	local ltex_wroot = find_root()
	local dirs = {}
	if ltex_wroot ~= nil then
		for fname, ftype in vim.fs.dir(ltex_wroot) do
			if ftype:match('directory') and
				(fname:match('^%.vim$') or fname:match('^%.vscode$')) then
				insert(dirs, ltex_wroot .. '/' .. fname)
			end
		end
	end
	return dirs
end

local ltex_extfiles = function(rule)
	M.ltex_wdirs = M.ltex_wdirs or ltex_getwdirs()
	local files = {}
	for _, dir in ipairs(M.ltex_wdirs) do
		for fname, ftype in vim.fs.dir(dir) do
			if fname:match('ltex%.' .. rule .. '%.') and ftype:match('file') then
				insert(files, dir .. '/' .. fname)
			end
		end
	end
	return ipairs(files)
end

M.ltex_disabledrules = function(defaults)
	local files = defaults or {}
	for _, file in ltex_extfiles('disabledRules') do
		local _, _, lang = file:find('ltex%.disabledRules%.([%-%a]+)%.txt$')
		files[lang] = files[lang] or {}
		local fullpath = vim.fs.normalize(file, ':p')
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

M.ltex_dictionaries = function(defaults)
	local files = defaults or {}
	for _, file in ltex_extfiles('dictionary') do
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
		if lang == 'en' then
			files['en-US'] = files['en-US'] or {}
			files['en-GB'] = files['en-GB'] or {}
			insert(files['en-US'], ':' .. fullpath)
			insert(files['en-GB'], ':' .. fullpath)
		end
		if lang == 'pt' then
			files['pt-BR'] = files['pt-BR'] or {}
			insert(files['pt-BR'], ':' .. fullpath)
		end
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

M.ltex_falsepositives = function(defaults)
	local files = defaults or {}
	for _, file in ltex_extfiles('hiddenFalsePositives') do
		local _, _, lang = file:find('ltex%.hiddenFalsePositives%.([%-%a]+)%.txt$')
		files[lang] = files[lang] or {}
		local fullpath = vim.fs.normalize(file, ':p')
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
M.ltex_getsettings = function(bufnr)
	bufnr = bufnr or 0
	local ltex_server = vim.lsp.get_clients({ bufnr = bufnr, name = 'ltex' })[1]
	if ltex_server ~= nil then
		print(vim.inspect(ltex_server.config.settings))
	else
		print('No Ltex server attached to the buffer')
	end
end
-- }}} Ltex External file

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

-- Sessions {{{
local fzf_lua = require('fzf-lua')
local persistence = require('persistence')

-- local session_previewer = require('fzf-lua.previewer.builtin')

M.load_session = function(opt)
	local branch = opt[1]:match('//(.+)$')
	local path = opt[1]:gsub('//.+$', '')
	path = vim.fs.normalize(path)
	vim.notify('Loading session' .. path .. '\tbranch:' .. (branch or 'nil'), vim.log.levels.INFO)
	if vim.bo[0].filetype ~= 'dashboard' then
		persistence.save()
		vim.cmd('%bd!');
		-- for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		-- 	if vim.api.nvim_buf_is_loaded(buf) then
		-- 		vim.api.nvim_buf_delete(buf, { force = true })
		-- 	end
		-- end
	end
	vim.fn.chdir(path)
	if branch then
		local out = vim.system({ 'git', 'switch', branch }, { text = true }):wait()
		if out.stderr then
			vim.notify(out.stderr, vim.log.levels.ERROR)
			persistence.load()
			vim.cmd.Ex(path)
			vim.cmd('Git')
			vim.cmd('normal gU<esc>')
			return
		end
	end
	persistence.load()
end

M.delete_session = function(opt)
	local branch = opt[1]:match('//(.+)$')
	local path = opt[1]:gsub('//.+$', '')
	local session = path:gsub('^~', vim.uv.os_homedir()):gsub('[\\/:]+', '%%')
	if branch then session = session .. '%%' .. branch end
	local file = require('persistence.config').options.dir .. session .. '.vim'
	if vim.uv.fs_stat(file) then
		vim.fs.rm(file)
	end
end

M.save_session = function()
	vim.api.nvim_exec_autocmds('VimLeavePre', { group = 'persistence' })
	vim.notify('Session saved: ' .. vim.fn.getcwd(), vim.log.levels.INFO)
end

fzf_lua.config.set_action_helpstr(M.load_session, 'load-session')
fzf_lua.config.set_action_helpstr(M.delete_session, 'delete-session')
fzf_lua.config.set_action_helpstr(M.save_session, 'save-session')

M.find_session = function()
	local notification_title = '📌 persistence'
	local user_config = require('persistence.config')
	local iter = vim.uv.fs_scandir(user_config.options.dir)
	assert(iter ~= nil)
	local next_dir = vim.uv.fs_scandir_next(iter)
	if next_dir == nil then
		vim.notify('No session found', vim.log.levels.INFO)
		return
	end

	local opts = fzf_lua.config.normalize_opts({
		prompt = '📌Sessions:', cwd_prompt = false, file_icons = false, git_icons = false,
		cwd_header = false, no_header = true, cwd = user_config.options.dir,
		winopts = { col = 0.55, row = 0.35, width = 0.50, height = 0.35 },
		previewer = nil, formatter = nil,
		actions = {
			["enter"] = M.load_session,
			["ctrl-x"] = { M.delete_session, fzf_lua.actions.resume, header = "delete session" },
			["ctrl-s"] = { fn = M.save_session, header = "new session" },
		},
	} , {})
	opts = fzf_lua.core.set_header(opts, { "actions" })

	fzf_lua.fzf_exec(function(fzf_cb)
		local sessions = {}
		local slash = '/'
			if vim.fn.has('win32') == 1 then slash = '\\' end
		local homedir = vim.uv.os_homedir()
		for name, type in vim.fs.dir(user_config.options.dir) do
			if type == "file" then
				local stat = vim.uv.fs_stat(user_config.options.dir .. name)
				if stat then
					table.insert(sessions, {
						name = name:gsub('%.vim$', ''):gsub('%%', slash):gsub(homedir, '~'),
						sec = stat.mtime.sec, nsec = stat.mtime.nsec,
					})
				end
			end
		end
		table.sort(sessions, function(a, b)
			return
				(a.sec > b.sec) or 
				(a.sec == b.sec and a.nsec > b.nsec) or
				(a.sec == b.sec and a.nsec == a.nsec and a.name < b.name)
		end)
		for _, sess in ipairs(sessions) do
			fzf_cb(sess.name)
		end
		fzf_cb()
	end, opts)
end

-- }}} Sessions

return M

