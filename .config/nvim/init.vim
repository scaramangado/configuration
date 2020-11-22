set nocompatible

nnoremap <SPACE> <Nop>
let mapleader = " "

syntax on
filetype plugin on

set modelines=0

set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set ruler
set visualbell
set encoding=utf-8

set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noshiftround

set scrolloff=1
set backspace=indent,eol,start
set mouse=a

set clipboard=unnamedplus

nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" Plugins

call plug#begin()

Plug 'vimwiki/vimwiki'

call plug#end()

