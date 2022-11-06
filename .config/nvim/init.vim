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

source $HOME/.config/nvim/keymaps.vim

" Plugins

call plug#begin()

Plug 'vimwiki/vimwiki'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'udalov/kotlin-vim'

call plug#end()

" inoremap <silent><expr> <a-space> coc#refresh()
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

