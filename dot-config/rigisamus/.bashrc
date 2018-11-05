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

if which rbenv 2&>1 /dev/null; then eval "$(rbenv init -)"; fi

# Put your fun stuff here.
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

export PATH=$PATH:$HOME/.local/bin

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source $HOME/.local/lib64/python3.6/site-packages/powerline/bindings/bash/powerline.sh
#if which screenfetch > /dev/null; then screenfetch; fi
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"; 
