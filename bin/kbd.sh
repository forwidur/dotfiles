#!/bin/dash

export DISPLAY=:0
sudo -u mag /usr/bin/setxkbmap -option grp:ctrl_shift_toggle us,ru -option grp_led:scroll
sudo -u mag /usr/bin/xmodmap /home/mag/.xmodmap
