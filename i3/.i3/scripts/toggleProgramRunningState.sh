#!/bin/bash
# Launch the program passed in the first parameter if it isn't already
# running. If it is, kill it ungracefully.

# Process, stripped of input parameters:
PROCESS_NAME=(${1// / })
PROCESS_WITH_PARAMETERS=$1

pid=`pidof "${PROCESS_NAME}"`
if [[ -z "${pid}" ]]; then
  ${PROCESS_WITH_PARAMETERS} &
else
  kill -9 "${pid}"
fi
