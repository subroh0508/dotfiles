#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ~/dotfiles
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".config" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".ssh" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    ln -s "$SCRIPT_DIR/$f" "$HOME/$f"
    echo "$f"
done

ln -s "$SCRIPT_DIR/.ssh/config" "$HOME/.ssh/config"

