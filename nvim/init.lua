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

vim.opt.undodir = os.getenv("HOME") .. '/.vim/undo/'

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
require("lazy").setup({
	{ 'nvim-lua/plenary.nvim' },
	{ 'folke/which-key.nvim', event = 'VeryLazy' },
	{ 'nvim-treesitter/nvim-treesitter', 
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
		build = ':TSUpdate', },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{ 'navarasu/onedark.nvim',
		priority = 1000,
		config = function() vim.cmd.colorscheme 'onedark' end, },
	{ 'nvim-lualine/lualine.nvim' },
	{ 'tpope/vim-fugitive' },
	{ 'SirVer/ultisnips' },
	{ 'numToStr/Comment.nvim', opts = {}, lazy = false },
	{ 'kylechui/nvim-surround', event = 'VeryLazy' },
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
			'petertriho/cmp-git',
		}
	},
	{ 'mfussenegger/nvim-lint' },
	{ 'lervag/vimtex' },
	{ 'vigoux/ltex-ls.nvim', dependencies = { 'neovim/nvim-lspconfig' } },
	{ 'zbirenbaum/copilot.lua', event = 'InsertEnter' },
})
-- }}} Plugins

-- Mason {{{
require('mason').setup()
require('mason-lspconfig').setup()
-- }}} Mason

-- Treesitter {{{
vim.defer_fn(function()
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'c', 'cpp', 'go', 'lua', 'python', 'rust', 'latex',
			'javascript', 'typescript', 'vimdoc', 'vim', 'cmake',
		},
		auto_install = false,
		highlight = { enable = true },
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
	})
end, 0)
-- }}} Treesitter

-- Comment {{{
require('Comment').setup({
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = '<leader>cc',
        block = '<leader>bc',
    },
    opleader = {
        line = '<leader>c',
        block = '<leader>b',
    },
    extra = {
        above = '<leader>cO',
        below = '<leader>co',
        eol = '<leader>cA',
    },
    mappings = { basic = true, extra = true, },
})
-- }}} Comment

-- Gitsigns {{{
local gitsigns = require('gitsigns')
gitsigns.setup({
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
})
-- }}} Gitsigns

-- Fzf-Lua {{{
local fzf_lua = require('fzf-lua')
fzf_lua.setup({
	'default',
	fzf_opts = { ['--layout'] = 'default' },
})
map('n', '<space>p', fzf_lua.files)
map('n', '<space>b', fzf_lua.buffers)
map('n', '<space>g', fzf_lua.git_files)
map('n', '<space>f', fzf_lua.grep)
map('n', '<space>F', fzf_lua.live_grep)
map('n', '<space>l', fzf_lua.lines)
map('n', "<space>'", fzf_lua.marks)
map('n', '<space>r', fzf_lua.oldfiles)
map('n', '<space>:', fzf_lua.command_history)
map('n', '<space>/', fzf_lua.search_history)
map('n', '<space>c', fzf_lua.git_commits)
-- map('n', '<space>s', fzf_lua.snippets)
map('n', '<space>m', fzf_lua.keymaps)
map('n', '<space><F1>', fzf_lua.help_tags)
map('i', '<c-x><c-g>', fzf_lua.complete_path)
-- }}} Fzf-Lua

-- Ultisnips {{{
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
vim.g.UltiSnipsEditSplit = "vertical"
vim.g.snips_author = "ABREU, Leonardo C. de."
vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. '/.vim/UltiSnips' }
vim.fn['UltiSnips#map_keys#MapKeys']()
-- }}} Ultisnips

-- Lualine {{{
require('lualine').setup({
	options = {
		icons_enabled = false,
		theme = 'onedark',
		component_separators = '|',
		section_separators = '',
	},
})

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
-- }}} Vimtex

-- Nvim-Cmp {{{
local cmp = require('cmp')

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
	snippet = {
		expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.mapping.complete()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<c-p>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif has_words_before() then
				cmp.mapping.complete()
			else 
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'buffer' },
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'git' },
		{ name = 'path' },
	},
	completion = {
		autocomplete = false,
	},
})

require("cmp_git").setup({
	remotes = { 'origin', 'upstream', 'overleaf' },
})
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		}, {
		{ name = 'buffer' },
	})
})
-- }}} Nvim-Cmp

-- Nvim-Lint {{{
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
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
	map('n', '<space>f', function()
		vim.lsp.buf.format { async = true }
	end, opts)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.tsserver.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.rust_analyzer.setup { { capabilities = capabilities, on_attach = on_attach },
	settings = { ['rust-analyzer'] = {} }
}
lspconfig.texlab.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.clangd.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.cmake.setup { capabilities = capabilities, on_attach = on_attach }
lspconfig.r_language_server.setup { capabilities = capabilities, on_attach = on_attach }
-- }}} LSP

-- LTex {{{
require('ltex-ls').setup {
	capabilities = capabilities,
	on_attach = on_attach,
	use_spellfile = false,
	filetypes = { 'latex', 'plaintex', 'tex', 'bib', 'markdown', 'gitcommit', 'text', 'rst' },
	settings = {
		ltex = {
			language = 'auto',
			enabled = { 'latex', 'tex', 'bib', 'markdown', },
			diagnosticSeverity = 'information',
			sentenceCacheSize = 2000,
			enabledRules = {
				en_GB = { 'OXFORD_SPELLING_NOUNS' }
			},
			additionalRules = {
				enablePickyRules = true,
				motherTongue = 'pt-BR',
			},
			disabledRules = { },
			dictionary = (function()
				local files = {}
				for _, file in ipairs(vim.api.nvim_get_runtime_file('.vim/ltex.dictionary.*', true)) do
					local lang = vim.fn.fnamemodify(file, ':t:r'):match('ltex%.dictionary%.(.-)$')
					local fullpath = vim.fs.normalize(file, ':p')
					files[lang] = { ':' .. fullpath }
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
			end)(),
		},
	},
}
-- }}} LTex

-- Copilot {{{
require('copilot').setup({
	suggestion = { enabled = true, keymap = { accept = '<c-cr>' } },
	panel = { enabled = true },
	filetypes = {
		-- python = true, -- allow specific filetype
		["*"] = false,
	},
})
-- }}} Copilot

-- Zen-Mode {{{
map('n', '<a-f>', '<cmd>ZenMode<CR>')
map('i', '<a-f>', '<cmd>ZenMode<CR>a')
map('n', '<a-s>', '<cmd>Twilight<CR>')
map('i', '<a-s>', '<cmd>Twilight<CR>a')
-- }}} Zen-Mode
