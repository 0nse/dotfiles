augroup filetypedetect
  " Activate syntax highlighting for octave
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
  au! BufWritePre *.py call Load_python_configuration()
  " needed for spell check to work properly in included LaTeX files:
  au! BufWritePre *.tex syntax spell toplevel
augroup END

" Add odd file extension syntax highlighting
au BufRead,BufNewFile *.zcml set filetype=xml
au BufRead,BufNewFile *.pt set filetype=html
au BufRead,BufNewFile *.md set syntax=pandoc.markdown
