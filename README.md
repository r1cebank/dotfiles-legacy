# ~/.
These are the dotfiles I am using on Mac OS X, though, theoretically speaking,
these should also work on any Linux or Unix machine.

## Using These
```
$ git clone https://github.com/jluchiji/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ ./script/install
$ ./script/bootstrap
```
This should do the trick.

## Notes
1. In order to remove the need to `sudo` every time I install global npm
packages, I repurposed `~/.npm` from npm cache into the install directory for
all global npm modules. So, the new npm cache will live in `~/.npm/cache`, while
npm prefix will be changed to `~/.npm`

## License

MIT
