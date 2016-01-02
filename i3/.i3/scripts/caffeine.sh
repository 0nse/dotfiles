#!/bin/sh
# Enable/disable the screensaver/screen blanking/screen turning off
# Some commands will probably fail but that is negligible.
# Furthermore, Flux will be en- or disabled accordingly.

if [[ $1 == "on" ]]; then
  binaryValue=0
  xsetValue="-"
  pkill xflux-bin
  state="off"
elif [[ $1 == "off" ]]; then
  binaryValue=1
  xsetValue="+"
  xflux &
  state="on"
else
  echo "Allowed values are 'on' and 'off'."
  exit 1
fi

setterm --blank ${binaryValue} # switch screen blanking
setterm --powerdown ${binaryValue} # switch turning screen off
setterm --powersave ${state} # switch power saving
xset s ${state} # switch X fallback screensaver
xset ${xsetValue}dpms # switch DPMS

if [[ $1 == "off" ]]; then
  textMessage="Slumber pills: The effect has worn off."
else
  textMessage="Key induced slumber."
fi

notify-send "${textMessage}" -u low -t 500 -a "Caffeine"
exit 0
