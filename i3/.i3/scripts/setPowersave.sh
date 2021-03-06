#!/bin/sh
# Enable/disable the screensaver/screen blanking/screen turning off
# Some commands will probably fail but that is negligible.
# Furthermore, Flux will be en- or disabled accordingly.

# set this directory as current working directory:
cd "$(dirname "$0")"

SCRIPTS_DIR=`configs/getScriptsDir.sh`
STATE="${1}"

# default is disabling powersave:
BINARY_VALUE=0
# default is disabling powersave:
X_SET_VALUE="-"

setGlobalParameters() {
  case "${STATE}" in
    "off")
      # uses default values as initialised in head
      ;;
    "on")
      BINARY_VALUE=1
      X_SET_VALUE="+"
      ;;
    *)
      echo "Allowed values are 'on' and 'off'."
      exit 1
      ;;
  esac
}

modifyPowersaveOptions() {
  setterm --blank "${BINARY_VALUE}" # switch screen blanking
  setterm --powerdown "${BINARY_VALUE}" # switch turning screen off
  setterm --powersave "${STATE}" # switch power saving
  xset s "${STATE}" # switch X fallback screensaver
  xset "${X_SET_VALUE}"dpms # switch DPMS
}

toggleRedshift() {
  pkill -USR1 '^redshift$'
}

showTextMessage() {
  if [[ "${STATE}" == "on" ]]; then
    textMessage="Sleep tight."
  else
    textMessage="Pouring some coffee."
  fi

  notify-send "${textMessage}" -u low -t 500 -a "Caffeine"
}

setGlobalParameters
toggleRedshift
modifyPowersaveOptions
showTextMessage
