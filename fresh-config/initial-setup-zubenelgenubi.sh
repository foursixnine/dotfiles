#!/bin/bash
set -e

export SSH_KEY="$HOME/.ssh/id_rsa.pub"

cd ~

if [ ! -e $SSH_KEY ]; then
	ssh-keygen 
fi

cat $SSH_KEY

source /etc/os-release

if [ $ID_LIKE = "suse" ]; then
	sudo zypper --non-interactive  in  -t pattern devel_basis devel_ruby devel_perl devel_python devel_C_C++
	sudo zypper --non-interactive  in  --no-recommends git-core konsole
	sudo zypper --non-interactive  in  python-pip scrot
fi
echo -n "Copy your ssh key and add it to github!, press any key when you are done"
read KEY

git config --global user.email "santiago@zarate.co"
git config --global user.name "Santiago Zarate"

mkdir -p ~/Projects/foursixnine.io
mkdir -p ~/Applications

cd ~/Projects/foursixnine.io/

git clone git@github.com:foursixnine/mars-configurations.git
git clone git@github.com:Perl-Toolchain-Gang/local-lib.git

(
  cd local-lib
  perl Makefile.PL --bootstrap
  make test || echo "Perhaps Dependencies are needed"
  make install
  echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >>~/.bashrc
)

source ~/.bashrc 
curl -L https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm | perl - App::cpanminus
exit 0
