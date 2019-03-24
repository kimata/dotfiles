#!/usr/bin/zsh

ln -sf dircolors/.dircolors(:a) ~/.dircolors

ln -sf zsh/.zshrc(:a) ~/.zshrc
ln -sf zsh/.zshenv(:a) ~/.zshenv

ln -sf git/.gitconfig(:a) ~/.gitconfig

ln -sf tmux/.tmux.conf(:a) ~/.tmux.conf

mkdir -p ~/.emacs.d
ln -sf emacs/init.el(:a) ~/.emacs.d/init.el

echo "DONE"
