let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" a: the directory of the current file, unless it is a subdirectory of the cwd
" r: the nearest ancestor of the current file that contains one of these
" directories or files: .git .hg .svn .bzr _darcs
let g:ctrlp_working_path_mode = 'ra'
" fallback markers if no .git directory etc:
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.apk,*.svg,*/target/*,*/Music/*,*/Pictures/*,*.mp3,*.ogg,*.jpg,*.png,*.jpeg,*.gif,*.pdf
