#!/bin/bash
# This script requires xdotool to be installed. It launches ncmpcpp and floats
# the window when necessary (that is, when the window size is too small for
# ncmpcpp to start).

ACTIVE_WINDOW_PID=-1

function getPID {
  focused_window_id=$(xdotool getwindowfocus)
  active_window_id=$(xdotool getactivewindow)
  ACTIVE_WINDOW_PID=$(xdotool getwindowpid "$active_window_id")
}

function setTitle {
  title="${1}"
  xdotool search --onlyvisible --pid "${ACTIVE_WINDOW_PID}" \
                 --name "\a\b\c" set_window --name "${title}"
}

ncmpcpp
if [[ "$?" -ne 0 ]]; then
  getPID
  # this only works with a dedicated i3 for_window rule:
  setTitle "i3:FLOAT"
  ncmpcpp
fi
