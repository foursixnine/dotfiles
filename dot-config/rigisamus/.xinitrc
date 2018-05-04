#monitor=`xrandr | grep -i edp | cut -d " " -f 1`
#xrandr --newmode  "1440x900_60.00"  106.50  1440 1528 1672 1904  900 903 909 934 -hsync +vsync
#xrandr --addmode $monitor 1440x900_60.00
#xrandr --output $monitor --mode 1440x900_60.00
eval $(dbus-launch --sh-syntax --exit-with-session)
start-pulseaudio-x11
xrandr --dpi 160
xrdb -merge ~/.Xresources &
exec i3
