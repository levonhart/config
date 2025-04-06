-- vim: foldmethod=marker
-- Options {{{
vim.opt.encoding = 'utf8'
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.history = 500
vim.opt.numberwidth = 3
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autowrite = true
vim.opt.expandtab = false
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
	vim.g.neovide_opacity=0.9
	vim.g.neovide_floating_blur_amount_x = 0.0
	vim.g.neovide_floating_blur_amount_y = 0.0
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_cursor_trail_size=0.8
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_in_command_line = false
	vim.opt.guifont= { 'FiraCode Nerd Font', 'DejaVuSansM Nerd Font', 'Fira Code', ':h11' }
	vim.keymap.set('n', '<c-s-v>', '"+p')
	vim.keymap.set('i', '<c-s-v>', '<c-r><c-o>+')
	vim.opt.guicursor:prepend('n-v-c:block-Cursor/lCursor')

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
vim.g.maplocalleader = '\\'
local map = vim.keymap.set
map('n', '<a-h>', '<c-w><c-h>', { desc = 'Change window' })
map('n', '<a-j>', '<c-w><c-j>', { desc = 'Change window' })
map('n', '<a-k>', '<c-w><c-k>', { desc = 'Change window' })
map('n', '<a-l>', '<c-w><c-l>', { desc = 'Change window' })
map('n', '<c-q>', '<c-w><c-q>', { desc = 'Change window' })
map('n', '<c-s-j>', '<Cmd>move +1<cr>', { desc = 'Move line' })
map('n', '<c-s-k>', '<cmd>move -2<cr>', { desc = 'Move line' })
map('v', '<c-s-j>', ":move '>+1<cr>gv=gv", { desc = 'Move line' })
map('v', '<c-s-k>', ":move '<-2<cr>gv=gv", { desc = 'Move line' })
map('n', '<c-S-Down>', '<cmd>move +1<cr>', { desc = 'Move line' })
map('n', '<c-S-Up>', '<cmd>move -2<cr>', { desc = 'Move line' })
map('v', '<c-S-Down>', ":move '>+1<cr>gv=gv", { desc = 'Move line' })
map('v', '<c-S-Up>', ":move '<-2<cr>gv=gv", { desc = 'Move line' })
map('i', '<c-z>', '<c-g>u<esc>[s1z=`]a<c-g>u', { desc = 'Fix spelling' })
map('n', '<c-s>', ':<c-u>set spell!<cr>', { desc = 'Toggle spell check' })
map('n', '<leader>p', vim.cmd.Ex)
map('n', '<c-p>', vim.cmd.Re)
map("n", '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = 'Substitute all occurences of the word under cursor in the current file' })
map('n', '¨', '`^', { desc = 'Jump to last insert' })
map('n', 'ç', '`.', { desc = 'Jump to last change/yank' })
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('i', '<C-c>', '<Esc>')
map('n', '[q', "<cmd>cnext<CR>zz",
	{ desc = 'Go to previous error message' })
map('n', ']q', "<cmd>cprev<CR>zz",
	{ desc = 'Go to next error message' })
map('n', '[g', "<cmd>lnext<CR>zz",
	{ desc = 'Go to previous jump location' })
map('n', ']g', "<cmd>lprev<CR>zz",
	{ desc = 'Go to next jump location' })
map('n', '<space>e', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev,
	{ desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next,
	{ desc = 'Go to next diagnostic message' })
map('n', '<space>q', vim.diagnostic.setloclist)
-- }}} Keys

-- Plugins {{{
require('bootstrap')
require('lazy').setup {
	spec = {
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
		{ 'mrjones2014/lighthaus.nvim', config = function()
				require('lighthaus').setup { transparent = true }
				if vim.g.neovide then
					vim.cmd(string.format('highlight Normal guibg=%s', require('lighthaus.colors').bg))
				end
			end },
		{ 'nvim-lualine/lualine.nvim',
			dependencies =  { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine' },
		},
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
				'zbirenbaum/copilot-cmp',
			}
		},
		{ 'mfussenegger/nvim-lint' },
		{ 'lervag/vimtex' },
		-- { 'vigoux/ltex-ls.nvim', dependencies = { 'neovim/nvim-lspconfig' } },
		{ 'barreiroleo/ltex-extra.nvim', ft = { 'tex', 'latex', 'bib', 'markdown' }, branch = 'dev',
			config = function() require('ltex_extra').setup({
				load_langs = { 'en-US', 'en-GB', 'pt-BR' }, path = require('plugins').ltex_find(),
				log_level = 'info' })
			end
		},
		{ 'folke/trouble.nvim', opts = {} },
		{ 'zbirenbaum/copilot.lua', event = 'InsertEnter' },
		{ "zbirenbaum/copilot-cmp", config = function ()
			require("copilot_cmp").setup() end },
	},
	checker = { enabled  = false },
	custom_keys = { ["<localleader>l"] = false, ["<localleader>t"] = false, },
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
		vim.keymap.set('n', '<leader>hv', gitsigns.select_hunk, { buffer = bufnr, desc = 'Visual select git hunk' })
		vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
		vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Stage git hunk' })
		vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Undo last stage' })
		vim.keymap.set('n', '<leader>hX', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Reset git hunk' })

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
	'fzf-native',
	fzf_opts = { ['--layout'] = 'default' },
}
map('n', '<space>P', fzf_lua.files)
map('n', '<space>b', fzf_lua.buffers)
map('n', '<space>t', fzf_lua.tabs)
map('n', '<space>p', fzf_lua.git_files)
map('n', '<space>gg', fzf_lua.grep)
map('n', '<space>G', fzf_lua.live_grep)
map('n', '<space>gw', fzf_lua.grep_cword)
map('n', '<space>gW', fzf_lua.grep_cWORD)
map('n', '<space>l', fzf_lua.lines)
map('n', "<space>'", fzf_lua.marks)
map('n', '<space>r', fzf_lua.oldfiles)
map('n', '<space>:', fzf_lua.command_history)
map('n', '<space>c', fzf_lua.git_commits)
map('n', '<space>x', fzf_lua.git_commits)
map('n', '<space>/', fzf_lua.search_history)
-- map('n', '<space>s', fzf_lua.snippets)
map('n', '<space>m', fzf_lua.keymaps)
map('n', '<space>h', fzf_lua.help_tags)
map('n', '<space>z', fzf_lua.spell_suggest)
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
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = {
			{ 'copilot', symbols = { status = { icons = { unknown = '' } } } },
			'encoding',
			'fileformat',
			'filetype',
		},
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
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

vim.api.nvim_create_autocmd( 'User' , {
	group = vim.api.nvim_create_augroup('VimtexEvents', {}),
	pattern = 'VimtexEventInitPost',
	callback = function(ev)
		map( { 'n', 'o', 'x' }, '[e', '<plug>(vimtex-[m)', { buffer = ev.buf })
		map( { 'n', 'o', 'x' }, '[E', '<plug>(vimtex-[M)', { buffer = ev.buf })
		map( { 'n', 'o', 'x' }, ']e', '<plug>(vimtex-]m)', { buffer = ev.buf })
		map( { 'n', 'o', 'x' }, ']E', '<plug>(vimtex-]M)', { buffer = ev.buf })

		map( 'n', '<leader>t', '<plug>(vimtex-toc-open)',   { buffer = ev.buf })
		map( 'n', '<leader>T', '<plug>(vimtex-toc-toggle)', { buffer = ev.buf })
	end,
})
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
		{ name = 'git' },
		{ name = 'path' },
		-- { name = 'ultisnips' },
	}, {
		{ name = 'copilot' },
		{ name = 'buffer' },
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

-- cmp.event:on('menu_opened', function()
-- 	vim.b.copilot_suggestion_hidden = true
-- end)
--
-- cmp.event:on('menu_closed', function()
-- 	vim.b.copilot_suggestion_hidden = false
-- end)
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

	map('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Go to declaration (Lsp)' } )
	map('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition (Lsp)' } )
	map('n', 'gY', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to implementation (Lsp)' } )
	map('n', 'gy', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Go to type definition (Lsp)' } )
	map('n', 'gR', vim.lsp.buf.references, { buffer = bufnr, desc = 'Go to references (Lsp)' } )
	map('n', 'gS', vim.lsp.buf.document_symbol, { buffer = bufnr, desc = 'Document Symbols (Lsp)' } )
	map('n', '<leader>k', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Display symbol information (Lsp)' } )
	map('n', '<leader><C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Display signature (Lsp)' } )
	map('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Display signature (Lsp)' } )
	map({ 'n', 'v' }, '<leader>f', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action (Lsp)' } )
	map('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename (Lsp)' } )
	map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = 'Add workspace directory (Lsp)' } )
	map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = 'Remove workspace directory (Lsp)' } )
	map('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { buffer = bufnr, desc = 'List workspace folders (Lsp)' } )
	map('n', '<space>=', function()
		vim.lsp.buf.format { async = true }
	end, { buffer = bufnr, desc = 'Format document (Lsp)' } )
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
lspconfig.ts_ls.setup { capabilities = capabilities, on_attach = on_attach }

vim.g.latex_commands = { -- Ltex {{{
	['\\nocite{}'] = 'ignore',
	['\\todo'] = 'ignore',
	['\\NP'] = 'vowelDummy',
	['\\NPC'] = 'vowelDummy',
	['\\NPH'] = 'vowelDummy',
	['\\P'] = 'Dummy',
	['\\W'] = 'Dummy',
}
local ltex_settings = function() return {
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
			commands = vim.g.latex_commands,
		},
		additionalRules = {
			enablePickyRules = true,
			motherTongue = 'pt-BR',
		},
		disabledRules = plugins.ltex_disabledrules {
			['en-US'] = { 'TOO_LONG_SENTENCE', 'INSTANCE' },
			['en-GB'] = { 'TOO_LONG_SENTENCE', 'INSTANCE' },
		},
	},
}
end
vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'LspAttach' }, {
	pattern = { '*.tex' },
	callback = function(ev)
		local client = require('lspconfig.util').get_active_client_by_name(ev.buf, 'ltex')
		if client ~= nil then
			-- plugins.ltex_wdirs = nil
			client.config.settings = ltex_settings()
		end
	end,
})
lspconfig.ltex.setup { capabilities = capabilities, on_attach = on_attach,
	filetypes = { 'latex', 'plaintex', 'tex', 'bib', 'markdown', 'text', 'rst' },
	settings = ltex_settings(),
}
vim.api.nvim_create_user_command('LtexSettings', plugins.ltex_getsettings,
	{ desc = 'Print out Ltex Server loaded Settings' }) -- }}} Ltex
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
			local msg = string.sub((diagnostics[1].source or '') ..': '
				.. diagnostics[1].message:gsub('[\n\t]', '    '), 1, width)
			local hl = hl_echo_diagnostics[diagnostics[1].severity]
			vim.api.nvim_echo({{msg, hl}}, false, {})
		end
	end,
})
-- }}} Diagnostics

-- Trouble {{{
map("n", "<leader>tt", '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle Trouble' })
map("n", "<leader>tw", '<cmd>Trouble diagnostics toggle<cr>',
	{ desc = 'Trouble workspace diagnostics' })
map("n", "<leader>td", '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>',
	{ desc = 'Trouble document diagnostics' })
map("n", "<leader>tq", '<cmd>Trouble diagnostics toggle quickfix<cr>',
	{ desc = 'Trouble quickfix' })
map("n", "<leader>tl", '<cmd>Trouble diagnostics toggle loclist<cr>',
	{ desc = 'Trouble location list' })
map("n", "<leader>ts", '<cmd>Trouble diagnostics toggle lsp_document_symbols<cr>',
	{ desc = 'Lsp document symbols (Trouble)' })
map("n", "[t", function() require("trouble").next({skip_groups = true, jump = true}); end,
	{ desc = 'Go to next Trouble' })
map("n", "]t", function() require("trouble").previous({skip_groups = true, jump = true}); end,
	{ desc = 'Go to previous Trouble' })
-- }}} Trouble

-- Copilot {{{
require('copilot').setup {
	suggestion = { enabled = false, },
	panel = { enabled = false, keymap = { open = '<c-/>' }, },
	filetypes = {
		-- python = true, -- allow specific filetype
		-- ['*'] = false,
		tex = false,
	},
}
vim.cmd("silent! Copilot disable")
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
			{ desc = '✍ Edit', group = 'Boolean', action = 'enew', key = 'e' },
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
