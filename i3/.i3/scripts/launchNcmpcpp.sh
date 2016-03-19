#!/bin/bash
# This script launches ncmpcpp and floats the window when necessary (that is,
# when the window size is too small for ncmpcpp to start).

ncmpcpp
if [[ "$?" -ne 0 ]]; then
  i3 floating toggle
  ncmpcpp
fi
