" Navigate through visible lines, not logical ones
noremap <silent> j gj
noremap <silent> k gk
"
" End means end of file, beginning means beginning of file
noremap <silent> G G$
noremap <silent> gg gg0

" By default you can't backspace over auto-indentation, previous edits or line
" breaks. So change it if necessary
set backspace=indent,eol,start

" vim-sensible by Tim Pope: https://github.com/tpope/vim-sensible
" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

