let g:esearch = {
  \ 'adapter': 'rg',
  \ 'backend': 'nvim',
  \ 'out':     'win',
  \ 'use':     ['visual', 'hlsearch', 'last'],
  \}
hi ESearchMatch ctermfg=black ctermbg=blue guifg=#000000 guibg=#E6E6FA
call esearch#out#win#map('<C-t>', 'tab')
call esearch#out#win#map('<C-x>', 'split')
call esearch#out#win#map('<C-v>', 'vsplit')
call esearch#out#win#map('<C-n>', 'next')
call esearch#out#win#map('<C-j>', 'next-file')
call esearch#out#win#map('<C-p>', 'prev')
call esearch#out#win#map('<C-k>', 'prev-file')
