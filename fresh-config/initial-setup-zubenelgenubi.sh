#!/bin/bash
set -e

cd ~
ssh-keygen 
cat ~/.ssh/id_rsa.pub 


git config --global user.email "santiago@zarate.net.ve"
git config --global user.name "Santiago Zarate"

mkdir -p ~/Projects/foursixnine.io
mkdir -p ~/Applications

cd ~/Projects/foursixnine.io/

git clone git@github.com:foursixnine/mars-configurations.git

wget http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/local-lib-2.000019.tar.gz
tar -xvzf local-lib-2.000019.tar.gz -C /tmp
(
  cd /tmp/local-lib-2.000019
  perl Makefile.PL --bootstrap
  make test
  make install
  echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >>~/.bashrc
)

source ~/.bashrc 
curl -L https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm | perl - App::cpanminus
exit 0
