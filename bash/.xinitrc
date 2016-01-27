#!/usr/bin/env bash
USER_RESOURCES=$HOME/.Xresources
SCRIPTS_DIR=$HOME/.i3/scripts

if [ -f "${USER_RESOURCES}" ]; then
    xrdb -merge "${USER_RESOURCES}"
fi

# Key- and mouse-mapping:
"${SCRIPTS_DIR}"/loadKeyboardLayout.sh &

# PA:
pulseaudio -D

# GPG agent:
eval $(gpg-agent --daemon) &

# Hide mouse when not needed:
unclutter --timeout 2 &

# Set resolution and enable keyboard mouse navigation.
# Keynav is launched second or else it would use the wrong screen resolution:
"${SCRIPTS_DIR}"/setDisplays.sh off && keynav &

# Start redshift:
redshift -b 0.9:1.0 -l `sed -n 1p $HOME/.configs`

case "${XDG_VTNR}" in
  2) # TTY2
    exec dbus-launch --exit-with-session fluxbox
    ;;
  *)
    exec dbus-launch --exit-with-session i3
    ;;
esac
