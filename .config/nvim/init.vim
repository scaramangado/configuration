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

" Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
Plug 'doums/darcula'
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'

call plug#end()

"lua require("lsp_config")

"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=NONE ctermbg=NONE

hi Overflow ctermfg=210 guifg=#ff6b68
match Overflow /\%>119v.*/

autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

:function! SourceIfExists(file)
:  if filereadable(expand(a:file))
:    exe 'source' a:file
:  endif
:endfunction

call SourceIfExists("$HOME/.config/nvim/keymaps.vim")
call SourceIfExists("$HOME/.config/nvim/wsl.vim")
call SourceIfExists("$HOME/.config/nvim/colorscheme.vim")

