#!/bin/bash
set -e

export SSH_KEY="~/.ssh/id_rsa.pub" 

cd ~

if [ ! -e  $SSH_KEY ]; then
	ssh-keygen 
fi

cat $SSH_KEY


if [ $DISTRO = "suse" ]; then
	zypper in --non-interactive -t pattern devel_basis devel_ruby devel_perl devel_python devel_C_C++
	zypper in --non-interactive --no-recommends git-core konsole
	zypper in --non-interactive python-pip scrot
fi



git config --global user.email "santiago@zarate.net.ve"
git config --global user.name "Santiago Zarate"

mkdir -p ~/Projects/foursixnine.io
mkdir -p ~/Applications

cd ~/Projects/foursixnine.io/

git clone git@github.com:foursixnine/mars-configurations.git
git clone git@github.com:Perl-Toolchain-Gang/local-lib.git

(
  cd local-lib
  perl Makefile.PL --bootstrap
  make test
  make install
  echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >>~/.bashrc
)

source ~/.bashrc 
curl -L https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm | perl - App::cpanminus
exit 0
