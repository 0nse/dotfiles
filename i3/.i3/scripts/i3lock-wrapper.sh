#!/bin/bash

# Copyright (c) 2013 Artem Shinkarov <artyom.shinkaroff@gmail.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# set this directory as current working directory:
cd "$(dirname "$0")"

TEMP_FILE=$(mktemp --tmpdir i3lock-wrapper-XXXXXXXXXX.png)
SCRIPTS_DIR=`configs/getScriptsDir.sh`

toggleUnclutter() {
  # We kill and relaunch unclutter because it has leaks memory. This way it
  # will have to free the memory from time to time.
  "${SCRIPTS_DIR}"/toggleProgramRunningState.sh "unclutter --timeout 2"
}

loadLockscreen() {
  createLockscreenBackground
  i3lock -i "${TEMP_FILE}"
  rm "${TEMP_FILE}"
}

createLockscreenBackground() {
  scrot -d0 "${TEMP_FILE}"
  convert "${TEMP_FILE}" -blur 0x3 "${TEMP_FILE}"
}

toggleUnclutter
loadLockscreen
toggleUnclutter
