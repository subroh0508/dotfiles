#!/bin/bash

cd $HOME/

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
yay -Rs go

# Sync and update packages
yay -Syu

# Install Xorg
yay -S xorg-server xterm

# Install video driver for Intel
# lspci | grep -e VGA -e 3D
# yay -S xf86-video-intel

# Install display manager
yay -S lightdm lightdm-gtk-greeter
systemctl enable lightdm

# Install desktop enviroments
yay -S xfce4 xfce4-goodies gamin

# Install NetworkManager
yay -S networkmanager network-manager-applet xfce4-notifyd

systemctl start NetworkManager
systemctl enable NetworkManager
systemctl disable dhcpd

# Install sound driver
yay -S pulseaudio pavucontrol

# Install browsers
yay -S google-chrome firefox

# Install input methods
yay -S fcitx fcitx-mozc fcitx-im fcitx-configtool

# Install fonts
yay -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# Install OpenSSH and Generate keys
yay -S openssh xclip
$HOME/dotfiles/common/ssh-generate.sh
eval $(ssh-agent)
ssh-add $HOME/.ssh/id_rsa

