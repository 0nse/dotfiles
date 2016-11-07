" Space as leader
let mapleader = "\<space>"

" Show linenumbers
set nu

" Syntax highlighting
syntax on

" show at least one line above the cursor (see tpope/vim-sensible)
if !&scrolloff
  set scrolloff=1
endif

" Enable mouse
set mouse=a

" Remove any trailing whitespace contained within any lines
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Show matching [] and {}
set showmatch

" CTRL+W for sudo save
command! W w !sudo tee % > /dev/null

" Highlight focussed line
setlocal cursorline
