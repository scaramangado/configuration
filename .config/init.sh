#!/bin/bash
echo ".config-repo/" >> $HOME/.gitignore
git clone --bare https://github.com/scaramangado/configuration.git $HOME/.config-repo
git --git-dir=$HOME/.config-repo/ --work-tree=$HOME config --local status.showUntrackedFiles no
[ -f .zshrc] && mv .zshrc .zshrc.bak
git --git-dir=$HOME/.config-repo/ --work-tree=$HOME checkout
source .zshrc

