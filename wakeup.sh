#!/bin/bash

echo "WAKE UP UBUNTU!!! Please be patient"

echo 'apt-get update'
sudo apt-get update

echo 'installing git' 
sudo apt install git -y

echo "installing curl"
sudo apt install curl -y

echo "What name do you want to use in GIT user.name?"
echo "My is \"jonathanccardoso\""
read git_config_user_name
git config --global user.name "$git_config_user_name"

echo "What email do you want to use in GIT user.email?"
echo "My is \"jonathan99moura@hotmail.com\""
read git_config_user_email
git config --global user.email $git_config_user_email
clear

echo "Generating a SSH Key"
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo 'installing zsh'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh

echo 'installing autosuggestions' 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
source ~/.zshrc

echo 'installing code'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders

echo 'installing extensions'
code --install-extension dracula-theme.theme-dracula
code --install-extension yzhang.markdown-all-in-one
code --install-extension esbenp.prettier-vscode
code --install-extension yzhang.markdown-all-in-one

echo 'installing spotify' 
sudo snap install spotify

echo 'installing chromium'
sudo apt install chromium-browser -y

echo 'installing theme'
sudo apt install fonts-firacode -y
wget -O ~/.oh-my-zsh/themes/node.zsh-theme https://raw.githubusercontent.com/skuridin/oh-my-zsh-node-theme/master/node.zsh-theme
sed -i 's/.*ZSH_THEME=.*/ZSH_THEME="node"/g' ~/.zshrc

echo "installing Hyper"
sudo apt-get install gdebi
wget https://hyper-updates.now.sh/download/linux_deb
sudo gdebi linux_deb

echo "installing Insomnia"
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -
sudo apt-get install insomnia
clear

echo "commiting changes"
source ~/.zshrc
sudo dpkg --configure -a 
sudo apt-get update --fix-missing
sudo apt-get autoremove

clear

echo "finish installations"
