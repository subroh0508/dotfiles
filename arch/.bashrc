#!/bin/bash
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

. $HOME/dotfiles/common/alias.bash

