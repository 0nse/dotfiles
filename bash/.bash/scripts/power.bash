# set CPU frequency according to http://askubuntu.com/questions/20271/how-do-i-set-the-cpu-frequency-scaling-governor-for-all-cores-at-once
function setCpuGov {
  case $1 in
    conservative|ondemand|userspace|powersave|performance)
      echo "$1" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
      echo " > Currently used frequency:"
      cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq;;
    *) echo " > Your input was invalid. Supported modes are:"
       cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
       echo " > Currently used frequency is:"
       cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq;;
  esac
}

# control vga_switcheroo:
# ON = set deactivated card on (if any)
# OFF = set unused card off (if not already done)
# DIGD = switch to integrated
# DDIS = switch to discrete
# OWN = reowns vga_switcheroo
function setGraphics {
  echo "$1" > /sys/kernel/debug/vgaswitcheroo/switch
  if [ "$?" -ne "0" ] #if failed then own it and retry
  then
    LOGGEDINUSER=`whoami`
    sudo chmod -R 705 /sys/kernel/debug
    sudo chown -R $LOGGEDINUSER:users /sys/kernel/debug/vgaswitcheroo
  fi
#  case $1 in ON|OFF|DIGD|DDIS)
#    echo $1 > /sys/kernel/debug/vgaswitcheroo/switch
#    if [ $1 = "DDIS" ]
#    then
#      setRadeonPower auto
#    fi
#  esac
  echo "OFF" > /sys/kernel/debug/vgaswitcheroo/switch
  cat /sys/kernel/debug/vgaswitcheroo/switch
}

# control energy status of radeon card
# low, mid, high and auto are supported
# for more information see http://askubuntu.com/questions/116005/gnome-3-ati-fan-always-on/116045#116045
function setRadeonPower {
  if [ -f /sys/kernel/debug/dri/0/radeon_pm_info ] # check if file exists in 0
  then
    CARD=0
  else
    CARD=1
  fi
  case $1 in
  low|mid|high|auto)
    echo "$1" > /sys/class/drm/card$CARD/device/power_profile
    if [ "$?" -ne "0" ]  # failed, therefore own it and retry
    then
      LOGGEDINUSER=`whoami`
      sudo chown $LOGGEDINUSER:$LOGGEDINUSER /sys/class/drm/card$CARD/device/power_profile
      echo "$1" > /sys/class/drm/card$CARD/device/power_profile
    fi
    cat /sys/kernel/debug/dri/$CARD/radeon_pm_info;;
  *)
    echo " > Only low, mid, high and auto are supported. Current status:"
    cat /sys/kernel/debug/dri/$CARD/radeon_pm_info;;
  esac
}
