Repository for dotiles on Arch Linux system.

# Usage
- Clone repository.
- Per application, create a symlink. Note that the original file should stay in the folder of this repistory - the symlink should exist in the path where the application will seek for the config file. E.g.:
`ln -nfs \home\kevin\Code\dotfiles\i3 \home\kevin\.config`.

# Applications
- fish
- i3
- i3bar
- xinitrc

# TODO:
- emacs
- Visual Studio Code

# Remarks
Remember that symlinks are great. :) Built-in features like fish's function declaration via `function`, `funced` and `funcsave` follow the link and thereby
work as intended.