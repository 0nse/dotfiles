#!/bin/bash
usermodmap=$HOME/.Xmodmap

sleep 1 # sleep to allow udev finish loading the keyboard first
setxkbmap -layout us -variant altgr-intl

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

notify-send "Enjoy your feeling." -u low -t 500
