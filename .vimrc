set nocompatible
set t_Co=256
set encoding=utf-8

execute pathogen#infect()
syntax on
set background=dark
colorscheme torte

""" Airline-related: """
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

set laststatus=2
""" End of airline-related stuff """

""" Forces the initial window size to be a little bit wider """
if has("gui running")
  set lines=999 columns=999
endif
""" End of initial window size control """

" Various non-bool options:
set history=512
set tabstop=2
set shiftwidth=2
set so=7
set backspace=eol,start,indent
set tabpagemax=50
set colorcolumn=80
set matchtime=7
" Expands tabs to spaces; keeps indent levels; aligns the braces together:
set expandtab
set autoindent
set smartindent

set number
set wrap
set ruler
set noautoread
set noerrorbells
set novisualbell
set nobackup
set nowritebackup
set noswapfile

highlight ColorColumn ctermbg=DarkGray ctermfg=Blue
                      \ guibg=DarkGray   guifg=Blue
highlight Search cterm=underline ctermbg=NONE ctermfg=Yellow
                 \ gui=underline   guibg=NONE   guifg=Yellow
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=Blue
                     \ gui=underline   guibg=NONE   guifg=Blue
" End of non-bool options.

" Search options:
"Makes search case-agnostic, unless capital letters are present in pattern string:
set ignorecase
set smartcase

" Highlights the search results as they are typed in:
set hlsearch
set incsearch


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

" Easier reindenting of a visual selection: reselects a block after indent/outdent
vnoremap < <gv
vnoremap > >gv

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


""" Autocommands: """
" For any file type, jump to the position edited the last time:
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif
augroup END

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
  autocmd FileType gitcommit nnoremap <buffer> <localleader>c I#<space><esc>
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
  autocmd FileType python set shiftwidth=4
  autocmd FileType python set softtabstop=4
augroup END

augroup filetype_sh
  autocmd!
  autocmd FileType sh nnoremap <buffer> <localleader>c I#<space><esc>
augroup END
""" End of Autocommands. """
