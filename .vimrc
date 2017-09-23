set backspace=2
set nocompatible
set history=500
set number
set numberwidth=5
set hlsearch
set incsearch
set autowrite
set tabstop=4
set noswapfile


" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

"KeyBindings
nnoremap <C-t> :tabnew<CR>:Startify<CR>
inoremap <C-t> <Esc>:tabnew<CR>
nnoremap <C-z> :nohlsearch<CR>


"pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

"NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"CtrlP.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

"Csupport
let g:C_ObjExtension = '.obj'
let g:C_ExeExtension = '.exe'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Ack
  let g:ackprg = 'ag --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag -Q -l -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif

" bind K to search word under cursor
nnoremap K :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>


"Polyglot
" desativar highlights ---  let g:polyglot_disabled = ['css']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline+=\ %=%#warningmsg#
set statusline+=\ %=%{SyntasticStatuslineFlag()}
set statusline+=\ %=%*


"------------------------------------------------------------------------------
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



"Themes
set t_Co=256
syntax enable
set background=dark

colorscheme base16-onedark

"Airline
let g:airline_theme='onedark'

"Devicons"
let g:airline_powerline_fonts = 1
set encoding=utf8
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsDefaultFolderOpenSymbol = ''


"Startify
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
let g:startify_bookmarks = ['/d/Development/', '~/Onedrive/Documentos/Code', '~/Onedrive/Documentos/Matemática\ Industrial'] 
