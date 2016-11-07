" Highlight overlong lines
if exists('+colorcolumn')
  set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" jump to line 80:
noremap <silent> gl 80\|
" break overlong line at last fitting word:
noremap <silent> gL 80\|F r<CR>
