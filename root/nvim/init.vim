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

" Persistent undo
set undodir=~/.vim/undo/
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

" KeyBindings {{{ "
"nnoremap <C-t> :tabnew<CR>:Startify<CR>
inoremap <C-t> :<C-u>tabnew<CR>
nnoremap <C-z> :nohlsearch<CR>
noremap <C-j> 10j
noremap <C-k> 10k
nnoremap <A-h> <C-w><C-h>
nnoremap <A-j> <C-w><C-j>
nnoremap <A-k> <C-w><C-k>
nnoremap <A-l> <C-w><C-l>
"nnoremap <C-l> :<C-u>call UltiSnips#ListSnippets()<CR>
"inoremap <C-l> <Esc>:call UltiSnips#ListSnippets()<CR>
" }}} KeyBindings "
