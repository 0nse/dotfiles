" Search using C^p
nnoremap <c-p> :FZF<cr>

" taken from zenbro/dotfiles
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

" colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'String'],
  \ 'hl':      ['fg', 'String'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Function'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Number'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'LineNr'],
  \ 'pointer': ['fg', 'Function'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'PreProc'],
  \ 'header':  ['fg', 'Comment'] }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
