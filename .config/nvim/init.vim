set nocompatible
set termguicolors

nnoremap <SPACE> <Nop>
let mapleader = " "

syntax on
filetype plugin on
set completeopt=menuone,noselect,noinsert

set modelines=0

set number
set relativenumber

set ruler
set visualbell
set encoding=utf-8

set wrap
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noshiftround

set scrolloff=8
set backspace=indent,eol,start
set mouse=a

set clipboard=unnamedplus

set nohlsearch
set incsearch

" Disable arrow keys
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>

source $HOME/.config/nvim/keymaps.vim

" Plugins

call plug#begin()

Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
Plug 'doums/darcula'
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'

call plug#end()

"lua require("lsp_config")

"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

colorscheme darcula
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=NONE ctermbg=NONE

hi Overflow ctermfg=210 guifg=#ff6b68
match Overflow /\%>119v.*/

autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

