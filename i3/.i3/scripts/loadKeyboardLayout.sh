#!/bin/bash
#xorgVars=`psgrep -a Xorg`
export DISPLAY=:0
export HOME="/home/`users | awk '{print $1}'`"
# Obtain the greeter cookie:
export XAUTHORITY=`ls /tmp/serverauth.*`

usermodmap=$HOME/.Xmodmap

sleep 1 # sleep to allow udev finish loading the keyboard first
setxkbmap -layout us -variant altgr-intl -display $DISPLAY

if [ -f "$usermodmap" ]; then
    xmodmap -display $DISPLAY "$usermodmap"
fi

notify-send "Enjoy your feeling." -u low -t 500
