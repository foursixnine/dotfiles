export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

test -s ~/.alias && . ~/.alias || true

if which rbenv 2>&1 > /dev/null; then eval "$(rbenv init -)"; fi

# Put your fun stuff here.
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

export PATH=$PATH:$HOME/.local/bin:$HOME/perl5/bin

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
PYTHON_SITE_PATH=$(python -m site --user-site)
. $PYTHON_SITE_PATH/powerline/bindings/bash/powerline.sh

bluetooth_headphones() {
    dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci0/dev_70_26_05_56_A1_56 org.bluez.Device1.Connect
}
