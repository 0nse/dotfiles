function sourceConfig () {
  source .bash/"${1}".bash
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
sourceScript "fzf"
sourceScript "gpg"
sourceScript "mount"
sourceScript "music"
sourceScript "network"
sourceScript "power"
sourceScript "vim"

function rest {
  st &
  exit
}
