#!/bin/sh
# Send the header so that i3bar knows we want to use JSON:
echo '{"version": 1}'
# Begin the endless array.
# We send an empty first array of blocks to make the loop simpler:
echo '[[],'
exec conky -c $HOME/.i3/conky/conkyrc.json