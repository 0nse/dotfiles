#!/bin/bash
# Launch the program passed in the first parameter if it isn't already running.
# If it is, kill it ungracefully.
processName=$1

pid=`pidof "${processName}"`
if [[ -z "${pid}" ]]; then
  ${processName} &
else
  kill -9 "${pid}"
fi
