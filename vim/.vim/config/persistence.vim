" Undo-persistence
set undodir=$HOME/.vim/.generated/undo " where to save undo histories
set undofile                           " Save undo's after file closes
set undolevels=1000                    " How many undos
set undoreload=10000                   " number of lines to save for undo
" Backup and swap directories
set backupdir=$HOME/.vim/.generated/backup
set directory=$HOME/.vim/.generated/swap
