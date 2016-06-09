set nocompatible
set t_Co=256
set encoding=utf-8

execute pathogen#infect()
syntax on
set background=dark
colorscheme torte

set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim
set laststatus=2

if has("gui running")
  set lines=999 columns=999
endif

"set guifont=Liberation\ Mono\ Powerline\ 10
"let g:Powerline_symbols = 'fancy'

" Typical bool options:
set ignorecase
set smartcase
set number
set hlsearch
set expandtab
set autoindent
set smartindent
set wrap
set autoread
set ruler

set noerrorbells
set novisualbell

set nobackup
set nowb
set noswapfile
" End of bool options.


" Various non-bool options:
set history=512
set tabstop=2
set shiftwidth=2
set so=7
set backspace=eol,start,indent
set tabpagemax=50
set colorcolumn=80
highlight ColorColumn guibg=Black
" End of non-bool options.

" Key mappings:
let mapleader="\<Space>"
let g:mapleader="\<Space>"
let maplocalleader="\\"
nnoremap ; :
set pastetoggle=<F5>
nnoremap <Leader>w :w<CR>
nmap <Leader><Leader> V
map j gj
map k gk
nnoremap H g^
nnoremap L g$
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap Q <nop>
map q: :q

"commands for quick .vimrc editing - <leader>ev and <leader>sv
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"commands for surrounding a word with various characters
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" Switch off search highlight temporarily:
nnoremap <silent> <Leader>/ :nohlsearch<cr>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" use the autocompletion: C-N ard C-P
map! ^P ^[a. ^[hbmmi?\<^[2h"zdt.@z^Mywmx`mP xi
map! ^N ^[a. ^[hbmmi/\<^[2h"zdt.@z^Mywmx`mP xi


" Abbreviations autoexpanding into useful info:
iabbrev @@ a.szczerbiak@samsung.com
iabbrev (@@ Adam Szczerbiak (a.szczerbiak@samsung.com)
iabbrev @@@ szczerbiakadam@gmail.com
iabbrev (@@@ Adam Szczerbiak (szczerbiakadam@gmail.com)
iabbrev spam@ asz101.allegro@gmail.com

" End of autoexpanding abbreviations.


" Typo-s autofix:
iabbrev improt import
iabbrev sattic static
iabbrev mani main
iabbrev vodi void
iabbrev publci public
" End of typo-s autofixes.



" Autocommands:
augroup filetype_c
  autocmd!
  autocmd FileType c nnoremap <buffer> <localleader>c I//<space><esc>
augroup END

augroup filetype_cpp
  autocmd!
  autocmd FileType cpp nnoremap <buffer> <localleader>c I//<space><esc>
augroup END

augroup filetype_gitcommit
  autocmd!
  autocmd FileType gitcommit set cc=73
  autocmd FileType gitcommit set tw=72
augroup END

augroup filetype_java
  autocmd!
  autocmd FileType java nnoremap <buffer> <localleader>c I//<space><esc>
augroup END

augroup filetype_make
  autocmd!
  autocmd FileType make setlocal noexpandtab
augroup END

augroup filetype_python
  autocmd!
  autocmd FileType python nnoremap <buffer> <localleader>c I#<space><esc>
augroup END
" End of Autocommands.


" Stop that F1 key from interrupting workflow:
nnoremap <F1> <nop>
