let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf, aux'
let g:Tex_AutoFolding = 0

" Program for viewing PDF and PS-files
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_ViewRule_ps='zathura'
" Disable latexsuite doing crazy autocompletion
let g:Imap_FreezeImap=1

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

"function! Tex_ForwardSearchLaTeX()
"  let cmd = 'evince_forward_search ' . fnamemodify(Tex_GetMainFileName(), ":p:r") .  '.pdf ' . line(".") . ' ' . expand("%:p")
"  let output = system(cmd)
"endfunction
