" Quickly resize windows with a vertical split
map - <C-W>-
map + <C-W>+

" vim splits to right and bottom (just like i3)
set splitright
set splitbelow

" Remap arrow keys to navigate through windows
nmap <Left> <C-W>h
nmap <Right> <C-W>l
nmap <Up> <C-W>k
nmap <Down> <C-W>j

" Show cursorline in active windows only
augroup highlight_follows_focus
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

" set window height to zero
set wmh=0

" Always display the status line as by default, my wm configuration will not
" display window titles
set laststatus=2
