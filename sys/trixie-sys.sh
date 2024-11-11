#!/bin/bash

# Make bash scripts executable
find . -name "*.sh" -exec chmod +x {} \;

# sources.list
sudo apt-add-repository -y contrib
sudo apt-add-repository -y non-free-firmware
sudo apt-add-repository -y trixie-backports
sudo dpkg --add-architecture i386

#Essentials
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y curl aria2 wget git python3 python3-venv ca-certificates flatpak plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install apt-fast
export PATH=$PATH:/usr/local/sbin/
sudo /bin/bash "$(curl -sL https://git.io/vokNn)"

# GPU
sudo apt-fast install -y linux-headers-amd64 nvidia-driver firmware-misc-nonfree nvidia-cuda-dev nvidia-cuda-toolkit nvidiadriver-libs:i385 libnvoptix1

# Apps
INS_LO="libreoffice libreoffice-plasma libreoffice-kf5 libreoffice-qt5 libreoffice-script-provider-python libreoffice-sdbc-postgresql libreoffice-style-breeze libreoffice-dict-en libreoffice-dict-de libreoffice-dict-tr"
INS_CODING="tmux gcc clang make dbeaver-ce "
INS_CREATIVE="blender gimp obs-studio"
INS_GAMING="wine lutris winetricks protontricks gamemode vkbasalt mangohud mangohud:i386 goverlay vulkan-tools"
INS_MEDIA="mpv calibre qbittorrent"
INS_PERSONAL="keepassxc"
INS_MUSIC="ardour audacity  samplv1-lv2"
INS_TRAN="omegat okapi"

sudo apt-fast -y install $INS_CODING $INS_LO $INS_CREATIVE $INS_GAMING $INS_MEDIA $INS_PERSONAL $INS_MUSIC

# Apps that need manual care

# Coding
sys/coding/install_docker.sh
sys/coding/install_asdf.sh
sys/coding/install_neovim.sh

# Gaming
sys/gaming/install_steam.sh
sys/gaming/install_discord.sh
flatpak install flathub net.davidotek.pupgui2

# Personal
sys/install_logseq.sh

# Music Production
sys/install_music_prod.sh

echo "Publii: Need to install manually with packaged .deb install"
