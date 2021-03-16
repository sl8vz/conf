" Configuration {{{
set nocompatible
set exrc         "allows to setup a local vimrc 

set tabstop=8    "tab spaces

set cursorline   "highlight current line

set wildmenu    "menu autocomplete
set showmatch

set nohlsearch   "highlight matches
set ignorecase   "only for /
set smartcase    "do not ignore case if uppercase in /
set inccommand=split
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

filetype indent plugin on
set smartindent

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

set signcolumn=auto:2
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
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'vitalk/vim-shebang'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'romgrk/nvim-treesitter-context'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'machakann/vim-highlightedyank'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'qpkorr/vim-bufkill'
Plug 'npxbr/glow.nvim'
"Colorschemes
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'gruvbox-community/gruvbox'
Plug 'bluz71/vim-nightfly-guicolors'

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

"NERDtress
let g:NERDTreeWinPos = "right"

"Tagbar
let g:tagbar_left = 1
let g:tagbar_sort = 0
autocmd FileType tagbar setlocal nocursorline nocursorcolumn

"Bufkill
let g:BufKillCreateMappings = 0

"Lsp
lua require("lsp_cfg")

"Tree sitter
lua require("ts_cfg")

"Nvim completion
let g:completion_auto_change_source = 1

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
"let g:completion_sorting = "length"
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_trigger_keyword_length = 2
let g:completion_trigger_on_delete = 1
let g:completion_enable_auto_paren = 1
"let g:completion_chain_complete_list = [
"    \{'complete_items': ['lsp', 'snippet', 'path']},
"    \{'mode': '<c-p>'},
"    \{'mode': '<c-n>'}
"\]
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
nmap <expr> <F7> &filetype ==# 'fugitiveblame' ? ":quit\r" : ":Git blame\r"

"TagBar
nmap <F8> :TagbarToggle<CR>

map <F9> :NERDTreeToggle<CR>

"FZF
nmap <Leader>F :Files<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>l :Commits<CR>
nmap <Leader>G :Rg<CR>

nmap <Leader>g : call MyGrep('<cword>')<CR>
nmap <Leader>h : call MyGrepW('<cword>')<CR>

inoremap jj <esc>

map <F5> :!ctags-universal .<CR><CR>

nmap <Left> <<
nmap <Right> >>
nmap <Up> [e
nmap <Down> ]e

" navigate pop-up
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

imap  <c-s> <Plug>(completion_next_source)
imap  <c-d> <Plug>(completion_prev_source)

nnoremap <leader>hd :SignifyHunkDiff<cr>
nnoremap <leader>hu :SignifyHunkUndo<cr>
" }}}

" Autocmds {{{
"Quickfix window
augroup vimrc
    autocmd!
    autocmd FileType qf wincmd J
    autocmd QuickFixCmdPost * copen 8
    autocmd FileType gitcommit setlocal colorcolumn=50,72 | setlocal spell
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif " Notification after file change
augroup END
" }}}

"Colors {{{
set background=dark
colorscheme gruvbox
" }}}

" vim:foldmethod=marker:foldlevel=0
