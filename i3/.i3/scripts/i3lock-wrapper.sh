#!/usr/bin/env sh

# set this directory as current working directory:
cd "$(dirname "$0")"

TEMP_FILE=/tmp/screen_lock.png
SCRIPTS_DIR=`configs/getScriptsDir.sh`

toggleUnclutter() {
  # We kill and relaunch unclutter because it leaks memory. This way it will
  # have to free the memory from time to time.
  "${SCRIPTS_DIR}"/toggleProgramRunningState.sh "unclutter --timeout 2"
}

loadLockscreen() {
  createLockscreenBackground
  i3lock -e -i "${TEMP_FILE}"
  rm "${TEMP_FILE}"
}

createLockscreenBackground() {
  # This code was primarily taken from
  # https://www.reddit.com/r/i3wm/comments/5ag6y7/d9gcwpr/
  filters='gblur=sigma=8'
  resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')

  ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 \
  -vf "$filters" "$TEMP_FILE"
}

toggleUnclutter
loadLockscreen
toggleUnclutter
