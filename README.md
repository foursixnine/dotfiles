This repository is mainly for certain configuration i have for some machines, it is not meant for production use. You can use it, but don't blame me if your box is broken :)

# .dotfiles

I'm starting to use stow to manage dotfiles

* https://github.com/davidarrieta/dotfiles
* https://github.com/sarcasticadmin/dotfiles

For now

* git
* Xmodmap
* xbindkeys
* autorandr https://github.com/phillipberndt/autorandr

More to come, as I slowly switch from Tyr to Deimos and unify my i3 configs from Rigisamus, Phobos and Deimos, until Mars arrives (Circa 2021?)

One problem I currently have, is that I don't want to play too much with `XDG_CONFIG_HOME` which now maps to `~/.config` due to fear of (broken) software that won't respect it
however I guess I can try a ix between how FAI handles files and stow + make?

### How to stow add existing configuration

1. Go to the `.dotfiles` directory: `cd .dotfiles`
2. Create a dir with the name of the "package" you want, this can be virtually anything: `mkdir autorandr`, if the configuration files are under a strange location `~/.config/autorandr` 
   for instance, create the whole structure, right before the file/directory you want to store: `mkdir -p autorandr/.config` in this case
3. Copy your files `cp -r ~/.config/autorandr autorandr/.config`
4. Adopt the directory/package: `stow --adopt autorandr`
5. Now, you can remove the destination `rm -rf ~/.config/autorandr` and then restore the configuration files `stow --restow autorandr` and stow will take care of all the symlinks
6. Verify: `ls -la ~/.config | grep autorand`: `lrwxrwxrwx  1 foursixnine users   40 Sep  2 18:50 autorandr -> ../.dotfiles/autorandr/.config/autorandr`

### Interesting bits

For `git` I found out that you can use [conditional includes](https://git-scm.com/docs/git-config), so no need to switch git configs anymore (which solves the problem of wanting to have separate identities for work/normal life)

A post checkout hook is added to ensure that we don't push to master directly on work stuff (SUSE for that matter)

## Apple Macbook Pro Retina (2013)

Rigisamus is an apple mbp retina, so if you're looking for the configurations
that I have done, or if you're running Gentoo (4.14.x Kernel) you might find 
some information here quite interesting. Take a look at [rigisamus](https://github.com/foursixnine/mars-configurations/tree/master/dot-config/rigisamus)

