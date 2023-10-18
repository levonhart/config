-- vim: foldmethod=marker
require('bootstrap')
-- Options {{{
vim.opt.encoding = 'utf8'
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.history = 500
vim.opt.numberwidth = 3
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autowrite = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.updatetime = 100
vim.opt.swapfile = false
vim.opt.wildmenu = true
vim.opt.mouse = 'nvi'
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.spl = { 'en_gb', 'pt_br' }
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.colorcolumn = '90'
vim.opt.conceallevel = 2
vim.g.tex_flavor='latex'
vim.g.tex_conceal='abdmgs'

vim.opt.undodir = vim.loop.os_homedir() .. '/.vim/undo/'

if vim.fn.executable('rg') then
	vim.opt.grepformat = '%f:%l:%c:%m'
	vim.opt.grepprg = 'rg --vimgrep'
end
-- }}} Options

-- Neovide {{{
if vim.g.neovide then
	vim.g.neovide_refresh_rate=60
	vim.g.neovide_transparency=0.9
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_cursor_trail_size=0.8
	vim.o.guifont='FiraCode Nerd Font,DejaVuSansMono Nerd Font,Fira Code:h11'
	vim.keymap.set('n', '<c-s-v>', '"+p')
	vim.keymap.set('i', '<c-s-v>', '<c-r><c-o>+')

	local default_font = vim.o.guifont
	vim.keymap.set({ 'n', 'i' }, '<c-=>', function()
		local fsize = vim.o.guifont:match('^.*:h([^:]*).*$')
		fsize = tonumber(fsize) + 1
		local gfont = vim.o.guifont:gsub(':h([^:]*)', ':h' .. fsize)
		vim.o.guifont = gfont
	end)

	vim.keymap.set({ 'n', 'i' }, '<c-->', function()
		local fsize = vim.o.guifont:match('^.*:h([^:]*).*$')
		fsize = tonumber(fsize) - 1
		local gfont = vim.o.guifont:gsub(':h([^:]*)', ':h' .. fsize)
		vim.o.guifont = gfont
	end)
	vim.keymap.set({ 'n', 'i' }, '<c-0>', function()
		vim.o.guifont = default_font
	end)
end
-- }}} Neovide

-- Keys {{{
vim.g.mapleader = '\\'
local map = vim.keymap.set
map('n', '<a-h>', '<c-w><c-h>')
map('n', '<a-j>', '<c-w><c-j>')
map('n', '<a-k>', '<c-w><c-k>')
map('n', '<a-l>', '<c-w><c-l>')
map('n', '<c-J>', '<Cmd>move +1<cr>')
map('n', '<c-K>', '<cmd>move -2<cr>')
map('v', '<c-J>', ":move '>+1<cr>gv=gv")
map('v', '<c-K>', ":move '<-2<cr>gv=gv")
map('n', '<c-S-Down>', '<cmd>move +1<cr>')
map('n', '<c-S-Up>', '<cmd>move -2<cr>')
map('v', '<c-S-Down>', ":move '>+1<cr>gv=gv")
map('v', '<c-S-Up>', ":move '<-2<cr>gv=gv")
map('i', '<c-z>', '<c-g>u<esc>[s1z=`]a<c-g>u')
map('n', '<c-s>', ':<c-u>set spell!<cr>')
map('n', '<leader>p', vim.cmd.Ex)
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '[g', vim.diagnostic.goto_prev,
	{ desc = 'Go to previous diagnostic message' })
map('n', ']g', vim.diagnostic.goto_next,
	{ desc = 'Go to next diagnostic message' })
map('n', '<space>e', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<space>q', vim.diagnostic.setloclist)
-- }}} Keys

-- Plugins {{{
require('lazy').setup {
	{ 'nvim-lua/plenary.nvim' },
	-- { 'folke/which-key.nvim', opts = {}, event = 'VeryLazy' },
	{ 'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
		build = ':TSUpdate', },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'glepnir/dashboard-nvim', event = 'VimEnter',
		dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{ 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{ 'navarasu/onedark.nvim', priority = 1000, },
	{ 'mrjones2014/lighthaus.nvim', opts = {}, },
	{ 'nvim-lualine/lualine.nvim' },
	{ 'tpope/vim-fugitive' },
	{ 'SirVer/ultisnips' },
	{ 'numToStr/Comment.nvim', lazy = false },
	{ 'kylechui/nvim-surround', opts = {}, event = 'VeryLazy' },
	{ 'lewis6991/gitsigns.nvim' },
	{ 'NvChad/nvim-colorizer.lua', opts = {} },
	{ 'folke/twilight.nvim', opts = {} },
	{ 'folke/zen-mode.nvim', opts = {} },
	{ 'neovim/nvim-lspconfig', dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		}
	},
	{ 'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lua',
			-- 'quangnguyen30192/cmp-nvim-ultisnips',
			'petertriho/cmp-git',
		}
	},
	{ 'mfussenegger/nvim-lint' },
	{ 'lervag/vimtex' },
	{ 'vigoux/ltex-ls.nvim', dependencies = { 'neovim/nvim-lspconfig' } },
	{ 'zbirenbaum/copilot.lua', event = 'InsertEnter' },
}
vim.g.colors_name = 'lighthaus'
local plugins = require('plugins')
-- }}} Plugins

-- Mason {{{
require('mason').setup()
require('mason-lspconfig').setup()
-- }}} Mason

-- Comment {{{
require('Comment').setup {
    padding = true,
    sticky = true,
    ignore = nil,
    extra = { above = '<leader>cO', below = '<leader>co', eol = '<leader>cA', },
    mappings = { basic = false, extra = true, opleader = false },
}
-- Mappings
local comment = require('Comment.api')
map('n', '<leader>cc', function() plugins.comment_current_count(comment.comment.linewise) end,
	{ desc = 'Comment linewise' })
map('n', '<leader>bb', function() plugins.comment_current_count(comment.comment.blockwise) end,
	{ desc = 'Comment blockwise' })
map('n', '<leader>c<space>', function() plugins.comment_current_count(comment.toggle.linewise) end,
	{ desc = 'Toggle comment linewise' })
map('n', '<leader>b<space>', function() plugins.comment_current_count(comment.toggle.blockwise) end,
	{ desc = 'Toggle comment blockwise' })
map('n', '<leader>c', plugins.comment_move_count(comment, 'comment.linewise'),
	{ desc = 'Comment linewise', expr = true })
map('n', '<leader>b', plugins.comment_move_count(comment, 'comment.blockwise'),
	{ desc = 'Comment blockwise', expr = true })
map('x', '<leader>c<space>', function() plugins.comment_linewise_visual(comment.toggle) end,
	{ desc = 'Toggle comment on selection linewise' })
map('x', '<leader>b<space>', function() plugins.comment_blockwise_visual(comment.toggle) end,
	{ desc = 'Toggle comment on selection blockwise' })
map('x', '<leader>cc', function() plugins.comment_linewise_visual(comment.comment) end,
	{ desc = 'Comment selection linewise' })
map('x', '<leader>bb', function() plugins.comment_blockwise_visual(comment.comment) end,
	{ desc = 'Comment selection blockwise' })
map('n', '<leader>cu', function() plugins.comment_current_count(comment.uncomment.linewise) end,
	{ desc = 'Uncomment linewise' })
map('n', '<leader>bu', function() plugins.comment_current_count(comment.uncomment.blockwise) end,
	{ desc = 'Uncomment blockwise' })
map('x', '<leader>cu', function() plugins.comment_linewise_visual(comment.uncomment) end,
	{ desc = 'Uncomment selection linewise' })
map('x', '<leader>bu', function() plugins.comment_blockwise_visual(comment.uncomment) end,
	{ desc = 'Uncomment selection blockwise' })
-- }}} Comment

-- Gitsigns {{{
local gitsigns = require('gitsigns')
gitsigns.setup {
	-- See `:help gitsigns.txt`
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	},
	on_attach = function(bufnr)
		vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

		-- don't override the built-in and fugitive keymaps
		vim.keymap.set({ 'n', 'v' }, ']c', function()
			if vim.wo.diff then
				return ']c'
			end
			vim.schedule(function()
				gitsigns.next_hunk()
			end)
			return '<Ignore>'
		end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
		vim.keymap.set({ 'n', 'v' }, '[c', function()
			if vim.wo.diff then
				return '[c'
			end
			vim.schedule(function()
				gitsigns.prev_hunk()
			end)
			return '<Ignore>'
		end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
	end,
}
-- }}} Gitsigns

-- Fzf-Lua {{{
local fzf_lua = require('fzf-lua')
fzf_lua.setup {
	'default',
	fzf_opts = { ['--layout'] = 'default' },
}
map('n', '<space>p', fzf_lua.files)
map('n', '<space>b', fzf_lua.buffers)
map('n', '<space>g', fzf_lua.git_files)
map('n', '<space>f', fzf_lua.grep)
map('n', '<space>F', fzf_lua.live_grep)
map('n', '<space>l', fzf_lua.lines)
map('n', "<space>'", fzf_lua.marks)
map('n', '<space>r', fzf_lua.oldfiles)
map('n', '<space>:', fzf_lua.command_history)
map('n', '<space>c', fzf_lua.git_commits)
map('n', '<space>/', fzf_lua.search_history)
-- map('n', '<space>s', fzf_lua.snippets)
map('n', '<space>m', fzf_lua.keymaps)
map('n', '<space><F1>', fzf_lua.help_tags)
map('i', '<c-x><c-g>', fzf_lua.complete_path)
-- }}} Fzf-Lua

-- Ultisnips {{{
vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.UltiSnipsEditSplit = 'vertical'
vim.g.snips_author = 'ABREU, Leonardo C. de.'
vim.g.UltiSnipsSnippetDirectories = { vim.loop.os_homedir() .. '/.vim/UltiSnips' }
vim.fn['UltiSnips#map_keys#MapKeys']()
-- }}} Ultisnips

-- Lualine {{{
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'lighthaus',
		component_separators = '|',
		section_separators = '',
	},
}

-- }}} Lualine

-- Vimtex {{{
if vim.fn.executable('sioyek') then
	vim.g.vimtex_view_method = 'sioyek'
elseif vim.fn.executable('evince') then
	vim.g.vimtex_view_method = 'evince'
elseif vim.fn.executable('zathura') then
	vim.g.vimtex_view_method = 'zathura'
elseif vim.fn.executable('okular') then
	vim.g.vimtex_view_method = 'okular'
end
vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_compiler_latexmk = { continuous = 0 }
vim.g.vimtex_complete_enable = 0
vim.g.vimtex_imaps_leader = ';'
-- }}} Vimtex

-- Nvim-Cmp {{{
local cmp = require('cmp')

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup {
	snippet = {
		expand = function(args) vim.fn['UltiSnips#Anon'](args.body) end,
	},
	mapping = cmp.mapping.preset.insert({
		['<c-b>'] = cmp.mapping.scroll_docs(-4),
		['<c-f>'] = cmp.mapping.scroll_docs(4),
		['<c-space>'] = cmp.mapping.complete(),
		['<c-e>'] = cmp.mapping.abort(),
		['<cr>'] = cmp.mapping.confirm({ select = true }),
		['<c-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then cmp.select_next_item()
			elseif has_words_before() then cmp.complete()
			else fallback()
			end
		end, { 'i', 's' }),
		['<c-p>'] = cmp.mapping(function(fallback)
			cmp.mapping.complete()
			if cmp.visible() then cmp.select_prev_item()
			elseif has_words_before() then cmp.complete()
			else fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'ultisnips' },
	}, {
		{ name = 'buffer' },
		{ name = 'git' },
		{ name = 'path' },
	}),
	completion = {
		autocomplete = false,
	},
	experimental = {
		ghost_text = false -- this feature conflict with copilot.vim's preview.
	}
}

require('cmp_git').setup {
	remotes = { 'origin', 'upstream', 'overleaf' },
}
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.event:on('menu_opened', function()
	vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on('menu_closed', function()
	vim.b.copilot_suggestion_hidden = false
end)
-- }}} Nvim-Cmp

-- Nvim-Lint {{{
require('lint').linters_by_ft = {
	c = { 'clangtidy' },
	cpp = { 'clangtidy' },
}
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	callback = function()
		require('lint').try_lint()
	end,
})
-- }}} Nvim-Lint

-- LSP {{{
local on_attach = function(_, bufnr)
	vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

	local opts = { buffer = bufnr }
	map('n', 'gD', vim.lsp.buf.declaration, opts)
	map('n', 'gd', vim.lsp.buf.definition, opts)
	map('n', 'gY', vim.lsp.buf.implementation, opts)
	map('n', 'gy', vim.lsp.buf.type_definition, opts)
	map('n', '<leader>k', vim.lsp.buf.hover, opts)
	map('n', '<leader><C-k>', vim.lsp.buf.signature_help, opts)
	map({ 'n', 'v' }, '<leader>f', vim.lsp.buf.code_action, opts)
	map('n', '<leader>rn', vim.lsp.buf.rename, opts)
	map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	map('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	map('n', '<space>=', function()
		vim.lsp.buf.format { async = true }
	end, opts)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.rust_analyzer.setup { { capabilities = capabilities, on_attach = on_attach },
	settings = { ['rust-analyzer'] = {} }
}
lspconfig.texlab.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.clangd.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.cmake.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.r_language_server.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.tsserver.setup { capabilities = capabilities, on_attach = on_attach }

-- }}} LSP

-- init.lua autocommand {{{
vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter' }, {
	pattern = { '*.lua' },
	callback = function(ev)
		if vim.fs.normalize(ev.file, ':p'):match('%.config/nvim/') ~= nil then
			cmp.setup.filetype({ 'lua' }, {
				sources = cmp.config.sources({
					{ name = 'nvim_lua' },
					{ name = 'nvim_lsp' },
				}, {
					{ name = 'buffer' },
				})
			})
			lspconfig.lua_ls.setup { capabilities = capabilities, on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { 'vim' },},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file('', true),
							checkThirdParty = false,
						},
					}
				}
			}
		end
	end,
})
-- }}} init.lua autocommand

-- Diagnostics {{{
vim.diagnostic.config {
	virtual_text = false,
}
local s = vim.diagnostic.severity
-- hi groups to echo diagnostic messages under cursor
local hl_echo_diagnostics = {
	[s.WARN] ='DiagnosticWarn',
	[s.ERROR]='DiagnosticError',
	[s.INFO] ='DiagnosticInfo',
	[s.HINT] ='DiagnosticHint',
}
vim.api.nvim_create_autocmd('CursorMoved', {
	group = vim.api.nvim_create_augroup('DiagnosticUnderCursor', {}),
	callback = function(ev)
		local diagnostics = vim.diagnostic.get(ev.buf,
			{ lnum = vim.api.nvim_win_get_cursor(0)[1]-1 })
		if diagnostics ~= nil and diagnostics[1] ~= nil then
			local width = vim.o.columns - 15
			local msg = string.sub(diagnostics[1].source ..': '.. diagnostics[1].message, 1, width)
			local hl = hl_echo_diagnostics[diagnostics[1].severity]
			vim.api.nvim_echo({{msg, hl}}, false, {})
		end
	end,
})
-- }}} Diagnostics

-- LTex {{{
local ltex_ls = function() return {
	ltex = {
		checkFrequency = 'save',
		language = 'auto',
		enabled = { 'latex', 'tex', 'bib', 'markdown', },
		diagnosticSeverity = 'information',
		sentenceCacheSize = 2000,
		use_spellfile = true,
		enabledRules = {
			['en-GB'] = { 'OXFORD_SPELLING_NOUNS' }
		},
		latex = {
			commands = {
				["\\nocite{}"] = 'ignore',
				['\\todo'] = 'ignore',
			},
		},
		additionalRules = {
			enablePickyRules = true,
			motherTongue = 'pt-BR',
		},
		disabledRules = plugins.ltex_disabledrules {
			['en-US'] = { 'PASSIVE_VOICE', 'TOO_LONG_SENTENCE' },
			['en-GB'] = { 'PASSIVE_VOICE', 'TOO_LONG_SENTENCE' },
		},
		dictionary = plugins.ltex_dictionaries { },
		hiddenFalsePositives = plugins.ltex_falsepositives { },
	},
}
end
require('ltex-ls').setup {
	capabilities = capabilities,
	on_attach = on_attach,
	use_spellfile = true,
	filetypes = { 'latex', 'plaintex', 'tex', 'bib', 'markdown', 'text', 'rst' },
	settings = ltex_ls(),
}
vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'LspAttach' }, {
	pattern = { '*.tex' },
	callback = function(ev)
		local client = require('lspconfig.util').get_active_client_by_name(ev.buf, 'ltex')
		if client ~= nil then
			plugins.ltex_wdirs = nil
			client.config.settings = ltex_ls()
		end
	end,
})
vim.api.nvim_create_user_command('LtexSettings', plugins.ltex_getsettings,
	{ desc = 'Print out Ltex Server loaded Settings' })
-- }}} LTex

-- Copilot {{{
require('copilot').setup {
	suggestion = { enabled = true, keymap = { accept = '<c-cr>' } },
	panel = { enabled = true },
	filetypes = {
		-- python = true, -- allow specific filetype
		['*'] = false,
	},
}
-- }}} Copilot

-- Zen-Mode {{{
map('n', '<a-f>', '<cmd>ZenMode<CR>')
map('i', '<a-f>', '<cmd>ZenMode<CR>a')
map('n', '<a-s>', '<cmd>Twilight<CR>')
map('i', '<a-s>', '<cmd>Twilight<CR>a')
-- }}} Zen-Mode

-- Dashboard {{{
require('dashboard').setup {
	theme = 'hyper',
	shortcut_type = 'number',
	hide = { tabline = false, statusline = true },
	config = {
		shortcut = {
			{ desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
			{
				icon = ' ',
				icon_hl = '@variable',
				desc = 'Files',
				group = 'Label',
				action = 'FzfLua files',
				key = 'f',
			},
			{
				desc = ' Repos',
				group = 'DiagnosticHint',
				action = 'FzfLua files cwd=~/repos',
				key = 'a',
			},
			{
				desc = ' dotfiles',
				group = 'Number',
				action = 'FzfLua files cwd=~/.config',
				key = 'd',
			},
		},
		packages = { enable = true },
		project = { limit = 8, action = 'FzfLua files cwd=' },
		mru = { limit = 10, icon = '' },
		header = { '', -- 'THE LORD OF THE RINGS',
		'    Three Rings for the Elven-kings under the sky,             ',
		'      Seven for the Dwarf-lords in their halls of stone,       ',
		'    Nine for Mortal Men doomed to die,                         ',
		'      One for the Dark Lord on his dark throne                 ',
		'    In the Land of Mordor where the Shadows lie.               ',
		'      One Ring to rule them all, One Ring to find them,        ',
		'    One Ring to bring them all and in the darkness bind them   ',
		'      In the Land of Mordor where the Shadows lie.             '},
		footer = {
			'                          ._____________.',
			'       MM.         .MM    |             |',
			'       "MM._______.MM"    |  私は平和を |',
			'       /             \\    | 愛するパンダ|',
			'     /   dMMb   dMMb   \\  |      !!     |',
			'    /  dM"""Mb dM"""Mb  \\ |_____________|',
			'   |   MMMMM"/O\\"MMMMM   |      ||o      ',
			'   |   "MMM"/   \\"MMM"   |   .dMMM 8     ',
			'   |                     dMMMMMMMM        ',
			'   \\      \\       /     dMMMMMMMP       ',
			'  AMMMMMMMMM\\_____/MMMMMMMMMMMM"         ',
		},
	},
}
local colors = require('lighthaus.colors')
local hiDashboard = {
    DashboardShortCut = { fg = colors.blue3 },
    DashboardHeader = { fg = colors.blue, fmt = 'italic' },
    DashboardCenter = { fg = colors.cyan },
    DashboardFooter = { fg = colors.blue, fmt = 'bold' },
}
plugins.vim_highlights(hiDashboard)
map('n', '<c-t>', ':tabnew<CR>:Dashboard<CR>:echo "New tab"<CR>',
	{ desc = 'Open new tab' })
-- }}} Dashboard   
