#!/usr/bin/env bash
launchWM() {
  case "${XDG_VTNR}" in
    2) # TTY2
      exec fluxbox
      ;;
    *)
      exec i3
      ;;
  esac
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
}

launchRedshift() {
  SCREEN_BRIGHTNESS="0.9:1.0"
  LOCATION=`sed -n 1p "${HOME}"/.configs`

  redshift -b ${SCREEN_BRIGHTNESS} -l ${LOCATION} &
}

mountCloudStorage() {
  baseDirectory=$1

  password=`sed -n 4p "${HOME}"/.configs`
  echo "${password}" | encfs -S "${baseDirectory}"/.0 $HOME/cloud/pw

  password=`sed -n 5p "${HOME}"/.configs`
  echo "${password}" | encfs -S "${baseDirectory}"/.1 $HOME/cloud/share
}

loadPreferences
launchPrograms
mountCloudStorage "$HOME/.gdrive/Backup"
launchWM
