" vim: foldmethod=marker
" Geral {{{ "
set encoding=utf8
set backspace=2
set history=500
set number
set numberwidth=5
set hlsearch
set incsearch
set autowrite
set tabstop=4
set shiftwidth=4
set noswapfile
set updatetime=100
set wildmenu
if has('win32')
	set path+=$HOMEDRIVE/Program\\\ Files\\\ (x86)/Microsoft\\\ Visual\\\ Studio/2019/BuildTools/VC/Tools/MSVC/14.22.27905/include
	set path+=$HOMEDRIVE/Program\\\ Files\\\ (x86)/Windows\\\ Kits/10/Include/10.0.18362.0/**
endif

" Persistent undo
set undodir=~/.vim/undo/
if has('win32')
	set undodir=$HOME/vimfiles/undo/
endif
set undofile
set undolevels=1000
set undoreload=10000
" }}} Geral "

" KeyBindings {{{ "
nnoremap <C-t> :tabnew<CR>:Startify<CR>
inoremap <C-t> <Esc>:tabnew<CR>
nnoremap <C-z> :nohlsearch<CR>
map <C-j> 10<Down>
map <C-k> 10<Up>
" }}} KeyBindings "

" Vundle {{{ "
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
if has('win32')
	set rtp+=$HOME/vimfiles/bundle/Vundle.vim
	call vundle#begin('$HOME/vimfiles/bundle')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'rking/ag.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-repeat'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-surround'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}} Vundle "

" NERDTree {{{ "
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
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
let g:ctrlp_working_path_mode = 'ra'
" }}} CtrlP "

" Ag.vim {{{ "
let g:ag_working_path_mode="r" "procura a partir da raiz do projeto
" bind K to search word under cursor
nnoremap K :Ag <C-R><C-W><CR>
" }}} Ag.vim "

" Polyglot {{{ "
" desativar highlights ---  let g:polyglot_disabled = ['css']

"Latex-Box
let g:LatexBox_latexmk_preview_continuously=1 "Run latexmk in continuous mode

" }}} Polyglot "

" Syntastic {{{ "
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline+=\ %=%#warningmsg#
set statusline+=\ %=%{SyntasticStatuslineFlag()}
set statusline+=\ %=%*

    let g:syntastic_mode_map = {
        \ "mode": "active",
        \ "active_filetypes": [],
		\ "passive_filetypes": [] }
" }}} Syntastic "

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
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', $HOME.'/.vim/bundle/vim-snippets/UltiSnips']
if has('win32')
	let g:UltiSnipsSnippetDirectories=[$HOME.'/vimfiles/UltiSnips', $HOME.'/vimfiles/bundle/vim-snippets/UltiSnips']
endif
" }}} Ultisnips "

" Colors {{{ "
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" }}} Colors "

" GitGutter {{{ "
if has('win32')
	set runtimepath^=$HOME/vimfiles/bundle/ctrlp.vim
else
	set runtimepath^=~/.vim/bundle/ctrlp.vim
endif
let g:gitgutter_max_signs = 500  " default value
" }}} GitGutter "

" Themes {{{ "
set t_Co=256
syntax enable
set background=dark
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme base16-circus

"Airline let g:airline_theme='onedark'
" }}} Themes "

" Devicons {{{ "
let g:airline_powerline_fonts = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsDefaultFolderOpenSymbol = ''
" }}} Devicons "

" Startify {{{ "
let g:ascii=[
						\ ' ',
						\ '                          ._____________.',
						\ '       MM.         .MM    |             |',
						\ '       "MM._______.MM"    |  私は平和を |',
						\ '       /             \    | 愛するパンダ|',
						\ '     /   dMMb   dMMb   \  |      !!     |',
						\ '    /  dM"""Mb dM"""Mb  \ |_____________|',
						\ '   |   MMMMM"/O\"MMMMM   |      ||o',
						\ '   |   "MMM"/   \"MMM"   |   .dMMM 8',
						\ '   |                     dMMMMMMMM',
						\ '   \      \       /     dMMMMMMMP',
						\ ' AMMMMMMMMM\_____/MMMMMMMMMMMM"'
						\ ]
let g:startify_custom_header =
						\ 'map(startify#fortune#boxed() + g:ascii, "\"   \".v:val")'
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
let g:startify_bookmarks = ['~/Onedrive/Documentos/Matemática\ Industrial'] 
" }}} Startify "
