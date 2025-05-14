# Michael's dotfiles

Configuration files for everything I use frequently.

Ubuntu 24.04 LTS w/ Regolith 3 desktop

## Installation notes

* Install
  - kitty
    + May need to install kitty-terminfo package depending on install method
  - neovim
  - keepass2
  - ranger
  - qbittorrent
  - python3
    + pip (python3-full will install this)
    + `python3 -m pip install --break-system-packages neovim-remote pipenv jedi pynvim black pylint`
  - node/npm
    + `npm install -g eslint prettier globals @eslint/js eslint-plugin-vue`
  - zsh
  - oh-my-zsh
    + This changes default shell to zsh.
  - neofetch
  - libfuse2
  - universal-ctags
  - silversearcher-ag
  - exfalso
  - cmus
  - fortune + fortunes
  - trash-cli
  - htop
  - clang
    + clang-format

* Install Firefox plugins
  - Tree style tab
  - Vimmatic
  - Enhancer for YouTube
  - Sponsorblock

* Make symlinks in .local/bin for AppImages

* Remove regolith-wm-base-launchers package
  - WARNING: Make sure ~/.config/regolith2/i3/15_base_launchers has been copied first

* Install regolith packages
  - i3xrocks-time
  - i3xrocks-temp
  - May be others?

* May need to remove regolith-i3-control-center-gnome (conflicting i3 config with regolith-i3-control-center-regolith)

# TODO
* vimrc cleanup
* Review /etc/fstab and /etc/sudoers
* Remove unused features/options from kitty-nvim

Let me know if I've included your work without attribution, the wrong license etc.
