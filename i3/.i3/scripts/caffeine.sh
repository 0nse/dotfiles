#!/bin/sh
# Enable/disable the screensaver/screen blanking/screen turning off
# Some commands will probably fail but that is negligible.
# Furthermore, Flux will be en- or disabled accordingly.

if [[ $1 == "on" ]]; then
  binaryValue=0
  xsetValue="+"
  pkill xflux-bin
elif [[ $1 == "off" ]]; then
  binaryValue=10
  xsetValue="-"
  xflux &
else
  echo "Allowed values are 'on' and 'off'."
  exit 1
fi

setterm --blank ${binaryValue} # switch screen blanking
setterm --powerdown ${binaryValue} # switch turning screen off
setterm --powersave $1 # switch power saving
xset s $1 # switch X fallback screensaver
xset ${xsetValue}dpms # switch DPMS

if [[ $1 == "on" ]]; then
  textMessage="Slumber pills: The effect has worn off."
else
  textMessage="Key induced slumber."
fi

notify-send "${textMessage}" -u low -t 500 -a "Caffeine"
exit 0
