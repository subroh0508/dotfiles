```sh
# With bootable disk
curl -L https://gist.github.com/subroh0508/00d19791fe9b3114e8d4047e8534e42c | bash

# After reboot
git clone https://github.com/subroh0508/dotfiles.git
cd dotfiles/arch
bash adduser.sh ${username} ${userpasswd}
cd ../../
rm -rf dotfiles

# After logout -> login as added user
git clone https://github.com/subroh0508/dotfiles.git
sudo chmod +x dotfiles/arch/*
cd dotfiles/arch
bash install.sh
cd ../../
rm -rf dotfiles

# Register public key to GitHub
cat ~/.ssh/id_rsa.pub | xclip -selection c

git clone --recursive git@github.com:subroh0508/dotfiles.git
find dotfiles/ -name "*.sh" | xargs sudo chmod +x
cd dotfiles
bash link.sh

