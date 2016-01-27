#!/bin/bash
#xorgVars=`psgrep -a Xorg`
export DISPLAY=:0
export HOME="/home/`users | awk '{print $1}'`"
# Obtain the greeter cookie:
export XAUTHORITY=`ls /tmp/serverauth.*`

USER_MODMAP=$HOME/.Xmodmap

sleep 1 # sleep to allow udev finish loading the keyboard first
setxkbmap -layout us -variant altgr-intl -display "${DISPLAY}"

if [ -f "${USER_MODMAP}" ]; then
    xmodmap -display "${DISPLAY}" "${USER_MODMAP}"
fi

notify-send "Enjoy your feeling." -u low -t 500
