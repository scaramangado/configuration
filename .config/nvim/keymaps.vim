" Reload Config
nnoremap <F5> :source $MYVIMRC<CR>:echo "Refreshed config"<CR>
inoremap <F5> <ESC>:source $MYVIMRC<CR>:echo "Refreshed config"<CR>==gi
vnoremap <F5> <ESC>:source $MYVIMRC<CR>:echo "Refreshed config"<CR>gv=gv

" Mode Switching
nnoremap <C-Space> i
inoremap <C-Space> <Esc>l
cnoremap <C-Space> <Esc>

" Move current line
nnoremap <A-S-Down> :m .+1<CR>==
nnoremap <A-S-Up> :m .-2<CR>==
inoremap <A-S-Down> <Esc>:m .+1<CR>==gi
inoremap <A-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-S-Down> :m '>+1<CR>gv=gv
vnoremap <A-S-Up> :m '<-2<CR>gv=gv

" Delete current line
nnoremap <C-y> dd
inoremap <C-y> <ESC>dd==gi

