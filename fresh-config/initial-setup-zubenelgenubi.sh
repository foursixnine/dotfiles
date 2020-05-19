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
	# zypper --terse se --installed-only -t pattern | grep ^i+ | awk 'BEGIN { FS="|";  } { print $2  }' |tee opensuse-pattern
	# zypper --terse se --installed-only -t package | grep ^i+ | awk 'BEGIN { FS="|";  } { print $2  }' |tee opensuse-packages
	# while this is not entirely optimal, it can be improved to avoid packages like zoom or code-insiders to show up
	sudo zypper --non-interactive  in  -t pattern $(cat opensuse-patterns)
	sudo zypper --non-interactive  in  $(cat opensuse-packages)
fi
echo -n "Copy your ssh key and add it to github!, press any key when you are done"
read KEY

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
