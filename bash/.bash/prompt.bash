if [ -f ~/.bash_promptline ]; then
  source ~/.bash_promptline
else
  PS1='\[\e[1;33m\][\[\e[0;36m\] \u\[\e[00m\]: \[\e[0;33m\]\w\[\e[00m\], \[\e[0;36m\]\t \[\e[1;33m\]]\[\e[00m\]\n\$ '
fi

