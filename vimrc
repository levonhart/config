" vim: foldmethod=marker
" Geral {{{ "
" let g:mapleader="<Space>"

set encoding=utf8
set backspace=2
set history=500
set number
set numberwidth=3
set hlsearch
set incsearch
set autowrite
set tabstop=4
set shiftwidth=4
set noswapfile
set updatetime=100
set wildmenu
set mouse=nvi
set hidden
set nobackup
set nowritebackup
set spelllang=en_gb,pt_br
filetype plugin indent on

highlight CodeFormating ctermbg=red guibg=red

augroup CodeFormatingGroup
	autocmd!
	autocmd ColorScheme * highlight CodeFormating ctermbg=red guibg=red
	autocmd BufCreate,BufWinEnter *.{c,cpp,h,hpp,py,java,js,ts} match CodeFormating /\s\+$\|\%>124c.\+$/
	autocmd InsertEnter *.{c,cpp,h,hpp,py,java,js,ts} match CodeFormating /\s\+\%#\@<!$\|\%>124c.\+$/
	autocmd InsertLeave *.{c,cpp,h,hpp,py,java,js,ts} match CodeFormating  /\s\+$\|\%>124c.\+$/
	autocmd WinLeave *.{c,cpp,h,hpp,py,java,js,ts} call clearmatches()
	autocmd BufWinLeave *.{c,cpp,h,hpp,py,java,js,ts} call clearmatches()
augroup END

if has('win32')
	set path=.,./include,../include
	set path+=$HOMEDRIVE\/Program\\\ Files\\\ (x86)\/Microsoft\\\ Visual\\\ Studio\/*\/BuildTools\/VC\/Tools\/MSVC\/*\/include
	set path+=$HOMEDRIVE\/Program\\\ Files\\\ (x86)\/Windows\\\ Kits\/10\/Include\/*\/ucrt
endif
" Persistent undo
set undodir=~/.vim/undo/
if has('win32')
	set undodir=$HOME/vimfiles/undo/
endif
set undofile
set undolevels=1000
set undoreload=10000

" Tex settings
set conceallevel=2
let g:tex_flavor='latex'
let g:tex_conceal='abdmgs'

" Neovim Remote
" if has('win32')
"     call serverstart('\\.\pipe\nvim-socket')
" else
"     call serverstart('/tmp/nvimsocket')
" endif
" }}} Geral "

" Neovide (GUI) {{{ "
if exists("g:neovide")
	let g:neovide_refresh_rate=60
	" let g:neovide_refresh_rate_idle=5
	let g:neovide_transparency=0.9
	let g:neovide_floating_blur_amount_x = 2.0
	let g:neovide_floating_blur_amount_y = 2.0
	let g:neovide_scroll_animation_length = 0.3
	let g:neovide_cursor_trail_size=0.8
	set guifont=FiraCode\ Nerd\ Font,DejaVuSansMono\ Nerd\ Font,Fira\ Code:h11
	nmap <C-S-v> "+p
	imap <C-S-v> \<C-r>\<C-r>+
endif
" }}} Neovide (GUI) "

" KeyBindings {{{ "
nnoremap <C-t> :tabnew<CR>:Startify<CR>
" inoremap <C-t> <ESC>:<C-u>tabnew<CR>
" noremap <C-j> 10j
" noremap <C-k> 10k
nnoremap <A-h> <C-w><C-h>
nnoremap <A-j> <C-w><C-j>
nnoremap <A-k> <C-w><C-k>
nnoremap <A-l> <C-w><C-l>
nnoremap <C-S-Down> <Cmd>move +1<CR>
nnoremap <C-S-Up> <Cmd>move -2<CR>

inoremap <C-z> <C-g>u<ESC>[s1z=`]a<c-g>u
nnoremap <C-s> :<C-u>set spell!<CR>

" nnoremap <C-z> :nohlsearch<CR>
" nnoremap <C-l> :<C-u>call UltiSnips#ListSnippets()<CR>
" inoremap <C-l> <Esc>:call UltiSnips#ListSnippets()<CR>
" }}} KeyBindings "

" Vim-plug {{{ "

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
if has('win32')
	call plug#begin('$HOME/vimfiles/plugged')
else
	call plug#begin('~/.vim/plugged')
endif

Plug 'rking/ag.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-lsp-ale'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'vifm/vifm.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
" Plug 'jupyter-vim/jupyter-vim'
" Plug 'goerz/jupytext.vim'
" Plug 'flazz/vim-colorschemes'
Plug 'ayu-theme/ayu-vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'lervag/vimtex'
Plug 'godlygeek/tabular'
" Plug 'neoclide/coc.nvim', {'branch': 'release',
			" \ 'do': ':CocInstall coc-clangd coc-cmake coc-fzf-preview coc-jedi coc-json coc-tsserver'}
" Plug 'hugolgst/vimsence'
Plug 'ryanoasis/vim-devicons'
Plug 'rhysd/vim-grammarous'

" Initialize plugin system
call plug#end()

" }}} Vim-plug "

" Asyncomplete {{{ "
let g:asyncomplete_auto_popup = 0
inoremap <expr> <CR>  pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
imap <c-space>        <Plug>(asyncomplete_force_refresh)

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <C-n>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<C-n>" :
  \ asyncomplete#force_refresh()
inoremap <silent><expr> <C-p>
  \ pumvisible() ? "\<C-p>" :
  \ <SID>check_back_space() ? "\<C-p>" :
  \ asyncomplete#force_refresh()

" let g:asyncomplete_auto_completeopt = 0
" set completeopt=menuone,noinsert,noselect,preview
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" }}} Asyncomplete "

" Vim-lsp {{{ "
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer><silent> gd <plug>(lsp-definition)
    nmap <buffer><silent> gs <plug>(lsp-document-symbol-search)
    nmap <buffer><silent> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer><silent> gD <plug>(lsp-references)
	nmap <buffer><silent> gY <plug>(lsp-implementation)
	nmap <buffer><silent> gy <plug>(lsp-type-definition)
    nmap <buffer><silent> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer><silent> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer><silent> <leader>k <plug>(lsp-hover)
    nmap <buffer><silent> <leader>rn <plug>(lsp-rename)
	if has('nvim-0.4.0') || has('patch-8.1.1417')
	nnoremap <buffer><silent> <expr><c-j>
				\ lsp#document_hover_preview_winid() != v:null ? lsp#scroll(+4) : "\<c-j>"
	nnoremap <buffer><silent> <expr><c-k>
				\ lsp#document_hover_preview_winid() != v:null ? lsp#scroll(-4) : "\<c-k>"
	endif

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" }}} Vim-lsp "

" NERDTree {{{ "
" map <C-n> :NERDTreeToggle<CR>
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" }}} NERDTree "

" NERDcommenter {{{ "
let g:NERDSpaceDelims = 1				" Add spaces after comment delimiters by defaul
let g:NERDCompactSexyComs = 1			" Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'			" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1			" Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = {}			" Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1			" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1	" Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1		" Enable NERDCommenterToggle to check all selected lines is commented or not
" }}} NERDcommenter "

" CtrlP {{{ "
" let g:ctrlp_working_path_mode = 'ra'
" if has('win32')
"     set runtimepath^=$HOME/vimfiles/bundle/ctrlp.vim
" else
"     set runtimepath^=~/.vim/bundle/ctrlp.vim
" endif
"
" let g:ctrlp_map = '<c-\>'
" }}} CtrlP "

" Fzf {{{ "
nmap <Space> [fzf]
nnoremap [fzf]p :<C-W>Files<CR>
nnoremap [fzf]b :<C-W>Buffers<CR>
nnoremap [fzf]w :<C-W>Windows<CR>
nnoremap [fzf]g :<C-W>GFiles<CR>
nnoremap [fzf]l :<C-W>Lines<CR>
nnoremap [fzf]' :<C-W>Marks<CR>
nnoremap [fzf]r :<C-W>History<CR>
nnoremap [fzf]: :<C-W>History:<CR>
nnoremap [fzf]/ :<C-W>History/<CR>
nnoremap [fzf]c :<C-W>Commits<CR>
nnoremap [fzf]s :<C-W>Snippets<CR>
nnoremap [fzf]m :<C-W>Maps<CR>

" }}} Fzf "

" Ag.vim {{{ "
let g:ag_working_path_mode="r" "procura a partir da raiz do projeto
" bind K to search word under cursor
" nnoremap K :Ag <C-R><C-W><CR>
" }}} Ag.vim "

" Polyglot {{{ "
" desativar highlights ---  let g:polyglot_disabled = ['css']
" }}} Polyglot "

" Vimtex {{{ "
if executable('sioyek')
	let g:vimtex_view_method = 'sioyek'
elseif executable('evince')
	let g:vimtex_view_method = 'evince'
elseif executable('zathura')
	let g:vimtex_view_method = 'zathura'
elseif executable('okular')
	let g:vimtex_view_method = 'okular'
endif
let g:vimtex_quickfix_mode=2
let g:vimtex_quickfix_open_on_warning=0
let g:vimtex_compiler_latexmk = { 'continuous': 0 }
" }}} Vimtex "

" Grammarous {{{ "
let g:grammarous#languagetool_cmd = 'languagetool'
" }}} Grammarous "

" Emmet {{{ "
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" }}} Emmet "

" Ultisnips {{{ "
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:snips_author="ABREU, Leonardo C. de."
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', $HOME.'/.vim/plugged/vim-snippets/UltiSnips']
if has('win32')
	let g:UltiSnipsSnippetDirectories=[$HOME.'/vimfiles/UltiSnips', $HOME.'/vimfiles/plugged/vim-snippets/UltiSnips']
endif
" }}} Ultisnips "

" Colors {{{ "
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
"  if (has("nvim"))
"    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif
" }}} Colors "

" GitGutter {{{ "
if has('win32')
	let g:gitgutter_git_executable = $HOME.'/scoop/shims/git.exe'
endif
let g:gitgutter_max_signs = 500  " default value 500
" }}} GitGutter "

" Hexokinase {{{ "
" Color code colored
let g:Hexokinase_highlighters = [ 'virtual', 'foreground' ]
" }}} Hexokinase "

" Themes {{{ "
set t_Co=256
syntax enable
set background=dark
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
let ayucolor="dark"
colorscheme ayu
" }}} Themes "

" Airline {{{ "
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#alt_sep = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
let g:airline_theme='ayu'
" }}} Airline "

" Lightline {{{ "
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
  \ }
" }}} Lightline "

" Devicons {{{ "
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsDefaultFolderOpenSymbol = ''
" }}} Devicons "

" Startify {{{ "
let g:ascii=[
			\ '                                             _______________________',
			\ '   _______________________-------------------                       `\',
			\ ' /:--__                                                              |',
			\ '||< > |                                   ___________________________/',
			\ '| \__/_________________-------------------                         |',
			\ '|                                                                  |',
			\ ' |                       THE LORD OF THE RINGS                      |',
			\ ' |                                                                  |',
			\ ' |      "Three Rings for the Elven-kings under the sky,             |',
			\ '  |        Seven for the Dwarf-lords in their halls of stone,        |',
			\ '  |      Nine for Mortal Men doomed to die,                          |',
			\ '  |        One for the Dark Lord on his dark throne                  |',
			\ '  |      In the Land of Mordor where the Shadows lie.                 |',
			\ '   |       One Ring to rule them all, One Ring to find them,          |',
			\ '   |       One Ring to bring them all and in the darkness bind them   |',
			\ '   |     In the Land of Mordor where the Shadows lie.                |',
			\ '  |                                              ____________________|_',
			\ '  |  ___________________-------------------------                      `\',
			\ '  |/`--_                                                                 |',
			\ '  ||[ ]||                                            ___________________/',
			\ '   \===/___________________--------------------------'
			\ ]

let g:startify_custom_header =
			\ 'map(g:ascii, "\"   \".v:val")'
			" \ 'map(startify#fortune#boxed() + g:ascii, "\"   \".v:val")'
let g:startify_list_order = [
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Most recently used files'],
            \ 'files',
            \ ['   Most recently used files in the current directory:'],
            \ 'dir',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Commands:'],
            \ 'commands',
            \ ]
"let g:startify_bookmarks = ['repos']
" }}} Startify "

" Vimsense (discord) {{{ "
" let g:vimsence_small_text = 'NeoVim'
" let g:vimsence_small_image = 'neovim'
" }}} Vimsense (discord) "

" Goyo {{{ "
nnoremap <A-f> :Goyo<CR>
inoremap <A-f> <ESC>:Goyo<CR>a
" }}} Goyo "
