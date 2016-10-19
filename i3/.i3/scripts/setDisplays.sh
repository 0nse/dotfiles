#!/bin/bash
#WALLPAPER=$HOME/Pictures/wallpaper/OS/archbg.png
#WALLPAPER=$HOME/Pictures/wallpaper/Minimal/076_9y3lyMI.png
#WALLPAPER=$HOME/Pictures/wallpaper/Motivational/1360848659695.jpg
#WALLPAPER=$HOME/Pictures/wallpaper/Motivational/Ja4WRUp.jpg
#WALLPAPER=$HOME/Pictures/wallpaper/Landschaft+Wasser/papers.co-mo99-water-texture-flare-summer-wave-nature-sea.jpg
WALLPAPER=$HOME/Pictures/wallpaper/Landschaft+Wasser/TxwQYcL.png
#WALLPAPER=$HOME/Pictures/wallpaper/Nerdy/2014-12-10-224223_1920x1080_scrot.png
#WALLPAPER=$HOME/Pictures/wallpaper/Nerdy/tw_35125b376a289ae4ca2009674fb9e238.jpg

if [[ $1 == "reset" ]]; then
  xrandr --output LVDS --primary --mode 1366x768
  xrandr --output HDMI-0 --off
  exit 0;
fi

if [[ $1 != "wallpaper" ]]; then
  # grep for connected displays and cut at first whitespace.
  # This returns the display identifier:
  foundDisplays=(`xrandr -q | grep " connected" | cut -f1 -d ' '`)
  foundDisplaysLength=${#foundDisplays[*]}
  if [[ ${foundDisplaysLength} > 1 ]]; then
    for ((index=0; index<${foundDisplaysLength}; index++)); do
      currentDisplay=${foundDisplays[${index}]}

      # determine preferred resolution (which normally is the max resolution):
      preferredResolutions=(`xrandr -q | grep -E "( |\*)\+" | cut -f4 -d ' '`)
#      preferredResolutions=(`xrandr -q | grep -E "[[:digit:]]x[[:digit:]].*[[:digit:]]\.[[:digit:]]( |\*)\+" | cut -f4 -d ' '`)

      # set display name and preferred resolution to variables:
      case "${currentDisplay}" in
      LVDS*)
        LVDS=${currentDisplay}
        resolutionLVDS="${preferredResolutions[${index}]}"
        ;;
      HDMI*)
        HDMI=${currentDisplay}
        resolutionHDMI="${preferredResolutions[${index}]}"
        ;;
      VGA*)
        VGA=${currentDisplay}
        resolutionVGA="${preferredResolutions[${index}]}"
        ;;
      esac
    done

    # if there is a VGA monitor, connect it with LVDS and set it left or right of it
    if [[ -n "$VGA" ]]; then
      position=$1
      if [ ${position} != "right" ]; then
        position="left"
      fi
      xrandr --output ${LVDS} --mode ${resolutionLVDS} --primary --output ${VGA} --mode ${resolutionVGA} --${position}-of ${LVDS}

    # else connect HDMI and set LVDS "on" or off
    else
      xrandrCommand="xrandr --output ${HDMI} --mode ${resolutionHDMI} --primary"
      if [[ $1 == "right" ]]; then
        ${xrandrCommand} --output ${LVDS} --right-of ${HDMI} --mode ${resolutionLVDS}
      elif [[ $1 == "left" ]]; then
        # calculate x-position of HDMI to be 2px off the left to circumvent an X11-bug:
        position=`echo ${resolutionLVDS} | cut -f1 -d 'x'`
        let "position = ${position} + 2"
        ${xrandrCommand} --pos ${position}x2 --output ${LVDS} --mode ${resolutionLVDS}
      else
        # shortly activate IGD for turning on laptop display backlight:
        # source $HOME/.i3/scripts/setGraphics.sh
        # setGraphics ON > /dev/null
        # setGraphics OFF > /dev/null
        ${xrandrCommand} --output ${LVDS} --off
      fi
    fi
  fi
fi

# set wallpaper and suppress and error/warning messages (e.g. about color profiles):
feh --bg-fill ${WALLPAPER} > /dev/null 2>&1
