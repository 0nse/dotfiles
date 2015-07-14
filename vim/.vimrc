" set cursorline

" two spaces instead of tabs
set expandtab
set tabstop=2
set shiftwidth=2
retab

" switch to 8 color mode to let the terminal override colors
set t_Co=8

" show linenumbers
set nu

" syntax highlighting
syntax on

" colours
set background=dark
colorscheme solarized

" highlighted search
set hlsearch

" enable mouse
set mouse=a

" incremental search
set incsearch

" Remove any trailing whitespace contained within any lines
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Show matching [] and {}
set showmatch

" Set automatic indentation
set autoindent
set smartindent

" disable automatic indentation with F8
:nnoremap <F8> :setl noai nocin nosi inde=<CR>

" set spellcheck for ... with F10
:nnoremap <F10> :setlocal spell spelllang=

" Set title of window to file name
set title
" and reset title to cwd on exit via xterm
let &titleold=getcwd()

" CTRL+W for sudo save
command! W w !sudo tee % > /dev/null

" Navigate through visible lines, not logical ones
noremap <silent> j gj
noremap <silent> k gk
" End means end of file, beginning means beginning of file
noremap <silent> G G$
noremap <silent> gg gg0

" LaTeX
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" Program for viewing PDF and PS-files
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_ViewRule_ps='zathura'
" Disable latexsuite doing crazy autocompletion
let g:Imap_FreezeImap=1


" stack windows with CTRL and k / l
map <C-J> <C-W>k<C-W>_
map <C-K> <C-W>l<C-W>_

" set window height to zero
set wmh=0

" quickly resize windows with a vertical split
map - <C-W>-
map + <C-W>+

" resize vertical windows quickly with ALT-SHIFT-[<>]
map <M-<> <C-W><
map <M->> <C-W>>

" highlight focussed line
":setlocal cursorline
":hi CursorLine ctermbg=black ctermfg=grey

" Activate syntax highlighting for octave
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END

" Restore cursor position for all files (*):
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" add odd file extension syntax highlighting
au BufRead,BufNewFile *.zcml set filetype=xml
au BufRead,BufNewFile *.pt set filetype=html

" By default you can't backspace over auto-indentation, previous edits or line
" breaks. So change it if necessary
set backspace=indent,eol,start

" expand menu
set wildmode=longest,list,full
set wildmenu

" use the + register (X Window Clipboard)
" set clipboard=unnamedplus

" undo-persistence
set undodir=$HOME/.vim/undo " where to save undo histories
set undofile                " Save undo's after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" two column view mode
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" append export.bib's content to the currently focused file
let @b = ":sp $HOME/Desktop/export.bibyG:qGp"
