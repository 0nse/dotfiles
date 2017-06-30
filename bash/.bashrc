function sourceConfig () {
  source $HOME/.bash/"${1}".bash
}

function sourceScript () {
  sourceConfig scripts/"${1}"
}

sourceConfig "alias"
sourceConfig "defaults"
sourceConfig "exports"
sourceConfig "history"
sourceConfig "prompt"
sourceScript "clean"
sourceScript "enhancd"
sourceScript "fzf"
sourceScript "gpg"
sourceScript "mount"
sourceScript "music"
sourceScript "network"
sourceScript "power"
sourceScript "ranger"
sourceScript "vim"

function rest {
  st &
  exit
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
