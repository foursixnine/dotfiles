#!/bin/bash
# Credit goes to https://github.com/savoca/dotfiles/blob/367ad7275b22002fc0b4997638515e3950689c13/home/.bin/scripts/lock.sh
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
xset dpms force off
i3lock -u -i /tmp/screen.png
rm /tmp/screen.png
