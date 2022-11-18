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
endif
" }}} Neovide (GUI) "

" KeyBindings {{{ "
nnoremap <C-t> :tabnew<CR>:Startify<CR>
inoremap <C-t> :<C-u>tabnew<CR>
nnoremap <C-z> :nohlsearch<CR>
noremap <C-j> 10j
noremap <C-k> 10k
nnoremap <A-h> <C-w><C-h>
nnoremap <A-j> <C-w><C-j>
nnoremap <A-k> <C-w><C-k>
nnoremap <A-l> <C-w><C-l>
nnoremap <C-l> :<C-u>call UltiSnips#ListSnippets()<CR>
inoremap <C-l> <Esc>:call UltiSnips#ListSnippets()<CR>
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
" Plug 'chriskempson/base16-vim'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
" Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
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
Plug 'neoclide/coc.nvim', {'branch': 'release',
			\ 'do': ':CocInstall coc-clangd coc-cmake coc-fzf-preview coc-jedi coc-json coc-tsserver'}
" Plug 'hugolgst/vimsence'
Plug 'ryanoasis/vim-devicons'
Plug 'rhysd/vim-grammarous'

" Initialize plugin system
call plug#end()

" }}} Vim-plug "

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
nmap <C-p> [fzf]
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
let g:vimtex_quickfix_mode=2
let g:vimtex_quickfix_open_on_warning=0
" }}} Vimtex "

" Syntastic {{{ "
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_stl_format = "[Syntax: line:%fe (%e:%w)]"

set statusline+=\ %=%#warningmsg#
set statusline+=\ %=%{SyntasticStatuslineFlag()}
set statusline+=\ %=%*

let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": [],
		\ "passive_filetypes": [] }

" }}} Syntastic "

" Grammarous {{{ "
let g:grammarous#languagetool_cmd = 'languagetool'
" }}} Grammarous "

" Emmet {{{ "
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" }}} Emmet "

" Ultisnips {{{ "
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:snips_author="ABREU, Leonardo C. de."
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', $HOME.'/.vim/plugged/vim-snippets/UltiSnips']
if has('win32')
	let g:UltiSnipsSnippetDirectories=[$HOME.'/vimfiles/UltiSnips', $HOME.'/vimfiles/plugged/vim-snippets/UltiSnips']
endif
" }}} Ultisnips "

" Coc.nvim {{{ "

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}} Coc.nvim  "

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
inoremap <A-f> <ESC><C-W>:Goyo<CR>
" }}} Goyo "
