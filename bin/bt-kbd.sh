#!/bin/sh

export XAUTHORITY=/home/mag/.Xauthority
export DISPLAY=:0

until /usr/bin/xinput --list "keyboard:ThinkPad Compact Bluetooth Keyboard with TrackPoint" > /dev/null 2>&1; do
  sleep 0.1
done

/usr/bin/xmodmap /home/mag/.xmodmap 2> /tmp/xmodmap_error
