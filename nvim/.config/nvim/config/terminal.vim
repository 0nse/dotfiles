" close terminal immediately after it ends
autocmd TermClose * bd!

" escape unfocuses neovim terminals
tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <leader>tt :tabnew<CR>:term<CR>
nnoremap <silent> <leader>tv :vsp<CR>:term<CR>
nnoremap <silent> <leader>ts :sp<CR>:term<CR>
nnoremap <silent> <leader>te :term<CR>
