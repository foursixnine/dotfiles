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

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Put your fun stuff here.
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

#export PATH="/Users/foursixnine/Library/Python/2.7/bin:$PATH"
#export PATH="/usr/local/opt/openssl/bin:$PATH"

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/share/powerline/bash/powerline.sh
neofetch
