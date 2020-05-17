#!/bin/bash
#
# Sample .xinitrc for SuSE Linux
# This script is called from 'startx' when you start an X session
#

#
# In case everything goes wrong, we at least fall back to a plain xterm
#
failsafe="xterm -ls -T Failsafe -geometry 80x24-0-0"
trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

#
# Some bash (1 and 2) settings to avoid trouble on a
# failed program call.
#
set +e > /dev/null 2>&1
set +u > /dev/null 2>&1
set +o posix  > /dev/null 2>&1
if type shopt > /dev/null 2>&1 ; then
    shopt -s execfail
else
    no_exit_on_failed_exec=1
fi

#
# Source common code shared between the
# X session and X init scripts
#
source /etc/X11/xinit/xinitrc.common

#
# Special for twm
#
case "$WINDOWMANAGER" in
    *) xsetroot -solid darkslateblue
esac


#
# Add your own lines here...
#

# This is legacy, and most likely can go away
$(/usr/lib/polkit-gnome-authentication-agent-1) &

eval $(dbus-launch --sh-syntax --exit-with-session)
start-pulseaudio-x11

#
# Uncomment next lines to activate asking for ssh passphrase
# Move this later to i3 autostart
if test -S "$SSH_AUTH_SOCK" -a -x "$SSH_ASKPASS"; then
      ssh-add < /dev/null
fi

exec i3

unset WINDOW_MANAGER STARTUP
exec $WINDOWMANAGER ${1+"$@"}

# call failsafe
exit 0
