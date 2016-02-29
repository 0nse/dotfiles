" Two spaces instead of tabs
set expandtab
set tabstop=2
set shiftwidth=2
retab

" Switch to 8 color mode to let the terminal override colors
set t_Co=8

" Show linenumbers
set nu

" Syntax highlighting
syntax on

" Colours
set background=dark
colorscheme solarized

" Highlighted search
set hlsearch

" Enable mouse
set mouse=a

" Incremental search
set incsearch

" Remove any trailing whitespace contained within any lines
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Show matching [] and {}
set showmatch

" Set automatic indentation
set autoindent

" Toggle automatic indentation for pasting
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

" Set spellcheck for ... with F10
nnoremap <F10> :setlocal spell! spelllang=

" Set title of window to file name
set title
" and reset title to cwd on exit via xterm
let &titleold=getcwd()
" Always display the status line as by default, my wm configuration will not
" display window titles
set laststatus=2

" CTRL+W for sudo save
command! W w !sudo tee % > /dev/null

" Find next/previous word spelled wrong
noremap <silent> [ [s
noremap <silent> ] ]s
" Navigate through visible lines, not logical ones
noremap <silent> j gj
noremap <silent> k gk
" End means end of file, beginning means beginning of file
noremap <silent> G G$
noremap <silent> gg gg0

" set window height to zero
set wmh=0

" Quickly resize windows with a vertical split
map - <C-W>-
map + <C-W>+

" Resize vertical windows quickly with ALT-SHIFT-[<>]
map <M-<> <C-W><
map <M->> <C-W>>

" Highlight focussed line
setlocal cursorline

" Reduce the performance impact of cursorline (and other tasks that redraw the
" terminal)
set lazyredraw

" Activate syntax highlighting for octave
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END

" Restore cursor position for all files (*)
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" Add odd file extension syntax highlighting
au BufRead,BufNewFile *.zcml set filetype=xml
au BufRead,BufNewFile *.pt set filetype=html
au BufRead,BufNewFile *.md set syntax=pandoc.markdown

" By default you can't backspace over auto-indentation, previous edits or line
" breaks. So change it if necessary
set backspace=indent,eol,start

" Expand menu
set wildmode=longest,list,full
set wildmenu

" Use the + register (X Window Clipboard)
" set clipboard=unnamedplus

" Undo-persistence
set undodir=$HOME/.vim/undo " where to save undo histories
set undofile                " Save undo's after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Two column view mode
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
" Multi column view
noremap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr> :set scb<cr>

" Append export.bib's content to the currently focused file
let @b = ":sp $HOME/Desktop/export.bibyG:qGp"

" Add pdb
let @p = "oimport pdb; pdb.set_trace()"


" vim-sensible by Tim Pope: https://github.com/tpope/vim-sensible
" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Instantly better vim 2013 by Damian Conway
" Highlight overlong lines
call matchadd('ColorColumn', '\%79v', 100)

" Plugins
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/goyo.vim'
  Plug 'mbbill/undotree'
  Plug 'unblevable/quick-scope'
  Plug 'scrooloose/syntastic'
call plug#end()

" LaTeX
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Undotree: Toggle
map <F3> :UndotreeToggle<CR>

" Quick-scope: Highlight only when needed
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
