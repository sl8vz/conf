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
set hlsearch    "highlight matches

set mouse=a

set scrolloff=5

set termguicolors "true colors

set colorcolumn=120

set relativenumber
set backspace=indent,eol,start

"More natural splits
set splitbelow
set splitright

set foldenable          " enable folding

"omni-completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest,menuone

" Enter behaves as C-y
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}

" Plugins {{{
runtime macros/matchit.vim

"
" Vundle
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
"Plugin 'tpope/vim-sleuth'
Plugin 'chazy/cscope_maps'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'myusuf3/numbers.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ervandew/supertab'
Plugin 'neomake/neomake'
"Colorschemes
Plugin 'tomasr/molokai'
Plugin 'w0ng/vim-hybrid'
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

"Supertab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabClosePreviewOnPopupClose = 1
"let g:SuperTabMappingForward = "<C-space>"
"let g:SuperTabMappingBackward = "<s-C-space>"
" }}}

" Functions {{{
function! MyGrep(arg)
     execute "silent grep! -I -r --exclude=tags --exclude=.tags --exclude=cscope.out --exclude=*.log*" a:arg "."
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
nmap <Leader>z :bd<CR>
nmap <Leader>q <C-w>z

nmap <S-j> <C-e>
nmap <S-k> <C-y>

nmap <F1> : call QuickfixToggle()<CR>

"Vugitive
nmap <F7> :Gblame<CR>

"TagBar
nmap <F8> :TagbarToggle<CR>

map <F9> :NERDTreeToggle<CR>

"FZF
nmap <Leader>f :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>b :Buffers<CR>

nmap <Leader>g : call MyGrep('<cword>')<CR>
nmap <Leader>G : call MyGrep(input("grep: "))<CR>

inoremap jj <esc>

map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
map <F6> :!cscope -bR<CR>:cs reset<CR><CR>
" }}}

" Autocmds {{{
"Quickfix window
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 8
augroup END

"Colors
set background=dark
colorscheme gruvbox
" }}}

" vim:foldmethod=marker:foldlevel=0
