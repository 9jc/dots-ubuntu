#! /bin/bash

# Num  Colour    #define         R G B
# 
# 0    black     COLOR_BLACK     0,0,0
# 1    red       COLOR_RED       1,0,0
# 2    green     COLOR_GREEN     0,1,0
# 3    yellow    COLOR_YELLOW    1,1,0
# 4    blue      COLOR_BLUE      0,0,1
# 5    magenta   COLOR_MAGENTA   1,0,1
# 6    cyan      COLOR_CYAN      0,1,1
# 7    white     COLOR_WHITE     1,1,1

#################################################################################
echo ""
echo ""
echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
echo "$(tput setaf 2)--------------------------[ Updating System ]----------------------------"
echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
sudo apt update -y && sudo apt upgrade -y                      # CMD
rm .bashrc
wget https://raw.githubusercontent.com/9jc/dots-ubuntu/main/.bashrc
#################################################################################
echo ""
echo ""
echo "--------------------------------------------------------------------------------------"
echo "$(tput setaf 4)-------[ Creating Seperate Directory's for programs ]-------$"
echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
#mkdir programs scripts vpn >> log.txt           # CMD
#################################################################################

echo ""
echo ""
echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
echo "$(tput setaf 2)------------[ Installing Necessary Applications ]--------------$"
echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
printf "%s\t\t\t\t\t%s\n" $(tput setaf 6)"00 | neovim - test editor" "01 | bashtop - system monitor" "02 | neofetch - utility" "        03 | exa - better ls" "04 | doas - do as another user" "05 | bleachbit - system cleaner" "06 | lynis - system auditer" "07 | aria2c - torrent downloader" "08 - yt-dlp - youtube downloader" 
echo "--------------------------------------------------------------------------------------"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update -y
sudo apt-get install neovim -y
sudo apt install nano -y
sudo apt install htop -y
sudo apt install neofetch -y
sudo apt install speedtest-cli
sudo apt install doas -y
sudo apt install bleachbit -y
sudo apt install lynis -y
sudo apt install aria2c -y

EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
sudo unzip -q exa.zip bin/exa -d /usr/local

pip install yt-dlp
git clone https://github.com/aristocratos/bashtop.git && cd bashtop && sudo make install > /dev/null    # CMD
rm -rf bashtop/

#################################################################################
echo ""
echo ""
echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
echo "$(tput setaf 5)--------------------------[ Installing NvChad ]----------------------------$"
echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1           # CMD
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync                            # CMD

#################################################################################
#echo ""
#echo ""
#echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
#echo "$(tput setaf 3)--------------------------[ Updating System ]----------------------------$"
#echo "$(tput setaf 3)--------------------------------------------------------------------------------------"
#
#################################################################################
echo ""
echo ""
echo "$(tput setaf 3)--------------------------------------[ TIPS ]------------------------------------------"
echo "$(tput setaf 1)---[ Make sure to change the server's default password ]---$"
echo "$(tput setaf 6)---- [ Run lynis --forensics / lynis audit system ] -----$"
echo "$(tput setaf 2)--[ Clean Your System With Bleachbit ; cmd=cleanup" ]--$"
echo "$(tput setaf 3)----------------------------------------------------------------------------------------"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo "------[ Now Exit ]-----"
echo "################################################################################# K@1b]tpRcn]3]7zJ
