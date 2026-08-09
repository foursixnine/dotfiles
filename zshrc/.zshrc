if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/foursixnine/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
fi

export PATH=/opt/homebrew/bin:$PATH

# fixes gpg signing
export GPG_TTY=$(tty)

# Programming languages are set here
# Add golang to path
export PATH=$PATH:$(go env GOPATH)/bin

# Because we don't wanna replace system's ruby (for now)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# enabling local::lib
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

source $HOME/.cargo/env
# no ruby stuff for noe eval "$(rbenv init - zsh)"

export EDITOR=nvim


# Created by `pipx` on 2024-12-02 04:03:10
#export PATH="$PATH:/Users/foursixnine/.local/bin"
# eval "$(register-python-argcomplete pipx)"

# Reexport PATH to include $HOME/bin first
export PATH="$HOME/bin:$PATH"

alias vim=$(which nvim)
alias ls='ls --color $@'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# enable exclusive things
bindkey '^R' history-incremental-search-backward

# https://snyk.io/articles/npm-security-best-practices-shai-hulud-attack/
alias npm='npq-hero'
