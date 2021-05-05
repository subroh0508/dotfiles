USER_NAME=$1
USER_PASSWD=$2

# Add user
useradd -m -g wheel ${USER_NAME}
echo "${USER_PASSWD}\n${USER_PASSWD}\n" | passwd ${USER_NAME}

# Install git
pacman -S git

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
echo "export GTK_IM_MODULE=fcitx" > ~/.xprofile
echo "export QT_IM_MODULE=fcitx" >> ~/.xprofile
echo "export XMODIFIERS=@im=fcitx" >> ~/.xprofile

# Install OpenSSH and generate keys
yay -S openssh
# mkdir ~/.ssh
# cd ~/.ssh
# ssh-keygen -t rsa -b 4096 -C "in-the-n@me-of.love"
# cd ~/

