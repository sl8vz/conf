" Configuration {{{
set nocompatible
syntax enable    "syntax
set exrc         "allows to setup a local vimrc 

set tabstop=8    "tab spaces
set autoindent
set cindent      "C-aware indentation

set number       "line number
set cursorline   "highlight current line

set wildmenu    "menu autocomplete
set showmatch

set incsearch   "search as characters are entered
set nohlsearch   "highlight matches
set ignorecase   "only for /
set smartcase    "do not ignore case if uppercase in /

set mouse=a

set scrolloff=5

set termguicolors "true colors

set colorcolumn=120

set relativenumber
set backspace=indent,eol,start

set undofile

"More natural splits
set splitbelow
set splitright

set foldenable          " enable folding

filetype indent plugin on

"omni-completion
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest,menuone

" Enter behaves as C-y
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}

" Plugins {{{
runtime macros/matchit.vim

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'simplyzhao/cscope_maps.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-unimpaired'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-tag'
Plug 'Shougo/echodoc.vim'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'qpkorr/vim-bufkill'
"Colorschemes
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()
" }}}

" Plugins conf  {{{
"Airline
set laststatus=2
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }
let g:airline#extensions#tagbar#enabled = 0

"gitgutter
set updatetime=250

"NERDtress
let g:NERDTreeWinPos = "right"

let g:tagbar_left = 1
let g:tagbar_sort = 0
autocmd FileType tagbar setlocal nocursorline nocursorcolumn


"Cscope
set nocscopetag
set csto=1
set cscopequickfix=s-,c-,d-,i-,t-,e-

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#tag#cache_limit_size = 50000000
set completeopt+=noselect
call deoplete#custom#option('omni_patterns', {
\ 'c': '[^. *\t]\%(\.\|->\)\w*',
\ 'cpp': ['[^. *\t]\%(\.\|->\)\w*', '[a-zA-Z_]\w*::'],
\})

" echodoc
set cmdheight=2
let g:echodoc_enable_at_startup = 1

"Ultisnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsListSnippets = "<F3>"

"Bufkill
let g:BufKillCreateMappings = 0

" }}}

" Functions {{{
function! MyGrep(arg)
     cexpr system("rg --vimgrep -g '!tags' " . expand(a:arg))
     execute 'redraw!'
endfunction

" The same but only on word boundary
function! MyGrepW(arg)
     cexpr system("rg -w --vimgrep -g '!tags' " . expand(a:arg))
     execute 'redraw!'
endfunction
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}

" Mappings {{{
"Mapping generic
let mapleader=","
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
" Split window vertically
nmap <Leader>v <C-w>v
" Split window horizontally
nmap <Leader>s <C-w>s
nmap <Leader>x <C-W>}
nmap <Leader>c <C-w>c

nmap <Leader>w :w<CR>
nmap <Leader>z :BD<CR>

nmap <S-j> 4<C-e>
nmap <S-k> 4<C-y>

"QuickFix toggle
nmap <F1> : call QuickfixToggle()<CR>

"Preview close
nmap <F2> <C-w>z

"Registers
nmap <F4> :reg<CR>

"Vugitive blame
nmap <expr> <F7> &filetype ==# 'fugitiveblame' ? ":quit\r" : ":Gblame\r"

"TagBar
nmap <F8> :TagbarToggle<CR>

map <F9> :NERDTreeToggle<CR>

"FZF
nmap <Leader>f :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>b :Buffers<CR>

nmap <Leader>g : call MyGrep('<cword>')<CR>
nmap <Leader>h : call MyGrepW('<cword>')<CR>
nmap <Leader>G : call MyGrep(input("grep: "))<CR>

inoremap jj <esc>

map <F5> :!ctags-universal .<CR><CR>
map <F6> :!cscope -bR<CR>:cs reset<CR><CR>

nmap <Left> <<
nmap <Right> >>
nmap <Up> [e
nmap <Down> ]e

"Deoplete navigate pop-up
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" }}}

" Autocmds {{{
"Quickfix window
augroup vimrc
    autocmd!
    autocmd QuickFixCmdPost * botright copen 8
    autocmd FileType gitcommit setlocal colorcolumn=50,72 | setlocal spell
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif " Notification after file change
augroup END
" }}}

"Colors {{{
set background=dark
colorscheme gruvbox
" }}}

" vim:foldmethod=marker:foldlevel=0
