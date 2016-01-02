#!/usr/bin/env bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Key- and mouse-mapping:
$HOME/.i3/scripts/loadKeyboardLayout.sh &

# PA:
pulseaudio -D

# GPG agent:
eval $(gpg-agent --daemon) &

# Hide mouse when not needed:
unclutter -idle 2 -noevents -grab &

# i3:
case "${XDG_VTNR}" in
  2) # TTY2
    exec dbus-launch --exit-with-session fluxbox
    ;;
  *)
    exec dbus-launch --exit-with-session i3
    ;;
esac
