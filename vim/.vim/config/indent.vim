" Two spaces instead of tabs
set expandtab
set tabstop=2
set shiftwidth=2
retab

" Set automatic indentation
set autoindent

" indented word wrap
set breakindent

" paste mode (unnecessary for nvim)
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>

function! Load_python_configuration()
  " 4 spaces instead of tabs
  set expandtab
  set tabstop=4
  set shiftwidth=4
  retab
  " backspace once to remove 4 spaces (tab-like behaviour)
  set softtabstop=4
endfunction
