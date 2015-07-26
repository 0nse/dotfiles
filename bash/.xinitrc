#!/usr/bin/env bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Key- and mouse-mapping:
$HOME/.i3/scripts/loadKeyboardLayout.sh &

# PA:
pulseaudio --start

# GPG agent:
eval $(gpg-agent --daemon) &

# Hide mouse when not needed:
unclutter -idle 2 -noevents -grab &

# i3:
exec dbus-launch --exit-with-session i3
