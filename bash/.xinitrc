#!/usr/bin/env bash
launchWM() {
  loadGnomeKeyRing
  disableClientSideDecoration
  case "${XDG_VTNR}" in
    1) # TTY1
      exec awesome
      ;;
    *)
      exec i3
      ;;
  esac
}

loadGnomeKeyRing() {
  dbus-update-activation-environment --systemd DISPLAY
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
}

loadPreferences() {
  USER_RESOURCES=$HOME/.Xresources
  SCRIPTS_DIR=$HOME/.i3/scripts

  if [ -f "${USER_RESOURCES}" ]; then
      xrdb -merge "${USER_RESOURCES}"
  fi

  "${SCRIPTS_DIR}"/loadKeyboardLayout.sh &
  # Set resolution and load wallpaper:
  "${SCRIPTS_DIR}"/setDisplays.sh off
}

launchPrograms() {
  pulseaudio -D
  eval $(gpg-agent --daemon) &
  # Hide mouse when not needed:
  unclutter --timeout 2 &
  launchRedshift
  # Enable keyboard mouse navigation (launch after setDisplays.sh so that it
  # uses the correct screen resolution):
  keynav &
  compton &
}

launchRedshift() {
  SCREEN_BRIGHTNESS="0.9:1.0"
  LOCATION=`sed -n 1p "${HOME}"/.configs`

  redshift -b ${SCREEN_BRIGHTNESS} -l ${LOCATION} &
}

disableClientSideDecoration() {
  export GTK_CSD=0
  export LD_PRELOAD=/usr/lib/libgtk3-nocsd.so.0
}

loadPreferences
launchPrograms
launchWM
