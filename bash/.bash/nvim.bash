if [ ! -e /tmp/nvimsocket ]; then
  NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim
else
  export EDITOR="nvr --remote"
  alias nvim="nvr --remote"
fi
