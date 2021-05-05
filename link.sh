#!/bin/bash

if [ $# != 1 ]; then
	echo "Tell me environment"
	echo "For example, 'arch', 'macos' and so on."
	exit 1
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)
ENV=$1

cd $HOME/dotfiles/$ENV
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".config" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".ssh" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    ln -s "$SCRIPT_DIR/$ENV/$f" "$HOME/$f"
done

ln -s "$SCRIPT_DIR/.ssh/config" "$HOME/.ssh/config"

if [ $ENV == "arch" ]; then
    ln -s "$SCRIPT_DIR/desktop/xfce4/terminal" "$HOME/.config/xfce4/terminal"
fi
