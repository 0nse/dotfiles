autocmd! BufReadPost * Neomake
autocmd! BufWritePost * Neomake
" open quickfix window but keep focus on buffer
let g:neomake_open_list=2
let g:neomake_javascript_enabled_makers = ['eslint']
nmap <Leader>no :lopen<CR>      " open location window
nmap <Leader>nc :lclose<CR>     " close location window
nmap <Leader>n, :ll<CR>         " go to current error/warning
nmap <Leader>nn :lnext<CR>      " next error/warning
nmap <Leader>np :lprev<CR>      " previous error/warning
