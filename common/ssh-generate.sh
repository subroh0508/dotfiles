#!/bin/bash

mkdir $HOME/.ssh
cd $HOME/.ssh
ssh-keygen -t rsa -b 4096 -C "in-the-n@me-of.love"
cd $HOME/

