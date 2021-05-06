#!/bin/bash
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

. $HOME/dotfiles/common/alias.bash

# For adb command
export PATH=$PATH:$HOME/Android/Sdk/platform-tools

