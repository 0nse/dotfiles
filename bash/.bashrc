#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
unset HISTFILESIZE

# set a fancy prompt (non-color, unless we know we "want" color)
if [[ "$TERM" == xterm-color ]]; then
  color_prompt=yes
fi

# my configuration:
PS1='\[\e[1;33m\][\[\e[0;36m\] \u\[\e[00m\]: \[\e[0;33m\]\w\[\e[00m\], \[\e[0;36m\]\t \[\e[1;33m\]]\[\e[00m\]\n\$ '

export EDITOR="nvim"
export TEXMFHOME=$HOME/.texmf-local
# make QT5 applications use GTK theme:
export QT_STYLE_OVERRIDE=GTK+
# sweet, sweet vi navigation:
set -o vi

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

# set permissions for music directory
# own to group audio and set rx for group
function reownMusicDir {
  cd $HOME
  echo "Setting 'audio' as group..."
  chgrp audio -R Music
  echo "Setting permissons for music directory..."
  chmod 4750 -R Music
  echo "Done."
  cd - >/dev/null
}

# enable video acceleration for radeon driver:
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=r600

function mountEhdd {
  sudo cryptsetup luksOpen /dev/sdb1 ehdd
  sudo vgchange -ay /dev/ehdd
  sudo mkdir -p /run/media/`whoami`/ehdd
  sleep 1
  sudo mount /dev/ehdd/main /run/media/`whoami`/ehdd
}

function umountEhdd {
  sudo umount /run/media/`whoami`/ehdd
  sudo vgchange -an /dev/ehdd
  sudo cryptsetup luksClose ehdd
}

function backupMusic {
  rsync -vrau --delete $HOME/Music/. /run/media/`whoami`/ehdd/music/.
}

# Size down album art and reduce its quality.
function resizeAlbumArt {
  convert -resize "1024x1024>" -quality 87 album.* _toUpload.jpg
  exit
}

function convertLoslessM4AtoFLAC {
  for file in *.m4a
    do
      ffmpeg -i "$file" -f flac "`basename "$file" .m4a`.flac"
    done
  rm -rf *.m4a
}

# Convert losless M4A to FLAC and then encode it to OGG.
function convertLoslessM4AtoOGG {
  convertLoslessM4AtoFLAC
  fastoggenc -q 9 -D -f *.flac
  addReplayGain
}

function convertMP3toOGG {
  fastoggenc -t -D -r -m . # quality of MP3, delete input, recursive, mp3
  addReplayGain
}

function convertM4AtoOGG {
  fastoggenc -q 8 -D -r -M . # quality 8, delete input, recursive, m4a
  addReplayGain
}

function convertFLACtoOGG {
  mv cover.jpg album.jpg
  fastoggenc -q 9 -D -r -f . # quality 9, delete input, recursive, flac
  addReplayGain
}

function extractBandcampAlbum {
  if [[ -z ${1} ]]; then
    exit -1
  fi

  archive="${1}"
  name=${archive%.zip}
  echo ${archive}
  echo ${name}

  unzip "${archive}"
  mv "${name}"/* .
  rm -r "${name}"
  rm "${archive}"

  convertFLACtoOGG
}

# Computes ReplayGain for either OGG, MP3 or FLAC files.
function addReplayGain {
  value=`find . -maxdepth 1 -iname "*.ogg" -type f | wc -l`
  if [[ $value > 0 ]]; then
    vorbisgain -a -f -r -s .
  else
    value=`find . -maxdepth 1 -iname "*.mp3" -type f | wc -l`
    if [[ $value > 0 ]]; then
      rename .MP3 .mp3 *.MP3 > /dev/null
      rename .Mp3 .mp3 *.Mp3 > /dev/null
      rename .mP3 .mp3 *.mP3 > /dev/null
      mp3gain -s i *.mp3
    else
      metaflac --add-replay-gain *.flac
    fi
  fi
  exit
}

# @see http://w3facility.org/question/gif-screencasting-the-unix-way/
function screencast {
  ffcast -s ffmpeg -r 15 -- -pix_fmt rgb24 temporaryScreencasting.gif
  echo "Optimising"
  filename=screencast_`date +"%y-%m-%d_%H:%M"`.gif
  convert -layers Optimize temporaryScreencasting.gif $filename
  rm temporaryScreencasting.gif
  echo "Done!"
}

function removeEXIFMetadata {
   exiftool -HistorySoftwareAgent= \
     -Software= \
     -HistoryWhen= \
     -HistoryAction= -HistoryChanged= \
     -HistoryInstanceID= \
     -DocumentID= \
     -InstanceID= \
     -OriginalDocumentID= \
     -XMPToolkit= \
     -Rating= \
     -PrimaryPlatform= \
     -UserComment= \
     -PhotoshopThumbnail= \
     -PhotoshopFormat= \
     -PhotoshopQuality=  \
     $1
}

function mountNexus {
  mkdir ~/nexus && jmtpfs ~/nexus
}

function umountNexus {
  fusermount -u ~/nexus && rm -r ~/nexus
}

# Optimises pacman and its caches and also deletes unused locales.
function optimiseSystem {
  sudo pkgcacheclean
  sudo pacman-optimize
  sudo sync
  sudo localepurge
  sudo journalctl --vacuum-time=7d
}

function deleteLaTeXTempFiles {
  rm *.{snm,nav,aux,bbl,bcf,blg,log,out,toc,run.xml,glo,glsdefs,glg,gls,ist} > /dev/null 2>&1
}

# @see https://wiki.archlinux.org/index.php/steam#Steam_runtime_issues
function deleteSteamLibraries {
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.1
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libgcc_s.so.1
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.6
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.1
}

# Encrypts a file and appends the "gpg"-extension to the encrypted output.
# First parameter:  file name.
# Second parameter: recipient email address.
# The public key of $2 must be known; see gpg --list-keys.
# If the second parameter is missing, the first mail address with an
# associated secret key will be used for encryption.
function encrypt {
  recipient=$2
  if [[ -z $2 ]]; then
    # retrieve the first mail address for which there is a secret key:
    mailAddress=`gpg -K | sed -n 4p | awk '{print $5}'`
    # truncate: "<mailAddress>" => "mailAddress":
    recipient=${mailAddress:1:-1}
  fi
  gpg --output $1.gpg --encrypt --armor --recipient $recipient $1
}

# Decrypts a file and removes the "gpg"-extension, if any.
# Prompts for the password.
# Use gpg-agent --daemon if you want a GUI and passphrase caching.
function decrypt {
  output=$1
  if [[ $1 == *.gpg ]]; then
    output=${output%.gpg}
  fi
  if [[ $1 == *.pgp ]]; then
    output=${output%.pgp}
  fi
  gpg --output $output --decrypt $1
}

# Kill any currently running DHCP daemon, wpa_supplicant service and
# turn off WiFi if a connection via Ethernet can be established.
function connectViaEthernet {
  sudo ip link set enp2s0 up
  sudo pkill dhcpcd
  sudo systemctl stop wpa_supplicant@wlp3s0b1.service
  sudo dhcpcd enp2s0
  if [[ $? == 0 ]]; then
    sudo rfkill block 0 # block WiFI
    sudo rfkill block 1 # block Bluetooth
  fi
}

# Kill any currently running DHCP daemon, activate WiFi and
# wpa_supplicant.
# TODO: we do not necessarily know what id belongs to WiFI. Thus, we would have to make the rfkill more dynamic
function connectViaWiFi {
  sudo ip link set wlp3s0b1 up
  sudo pkill dhcpcd
  sudo rfkill unblock 0 # activate WiFi
  sudo systemctl start wpa_supplicant@wlp3s0b1.service
  wait 1
  sudo dhcpcd wlp3s0b1
}

# test udev rules for pok3r: sudo udevadm test /bus/usb/devices/usb2/2-1/2-1.2/2-1.2.4/

function vimrc {
  vim "${HOME}"/.vim/vimrc
}

function nvimrc {
  nvim "${HOME}"/.config/nvim/init.vim
}

alias vim=nvim
