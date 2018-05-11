#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
	cd FILES
    sudo add-apt-repository ppa:gambas-team/gambas3 -y
    sudo apt update
    sudo dpkg -i *.deb
	sudo apt install xclip xfwm4 xscreensaver xscreensaver-data python-pyaudio shutter mplayer ubuntu-mate-core ubuntu-mate-desktop lightdm lightdm-gtk-greeter ubuntu-artwork devilspie libopenimageio1.6 libboost1.62-all-dev libopenvdb3.2 libavdevice-dev libjemalloc1 libspnav0 npm -y
    sudo apt install -f -y
    sudo npm install electron -g
	rm -rf /usr/share/backgraunds
    sudo apt install gambas3 -y
	echo "Downloading ZED OS Files"
	wget https://zedfiles.blob.core.windows.net/updates/update.tar.gz
	echo "Installing ZED OS Files"
	tar -zxvf update.tar.gz -C / &> /dev/null
	rm update.tar.gz
    chmod +x -R /sbin
    sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/zed/zed.plymouth 100
	echo "Select ZED OS Plymouth afther press ENTER"
	read
	sudo update-alternatives --config default.plymouth
	sudo update-initramfs -u
    sudo update-alternatives --set x-cursor-theme /etc/X11/cursors/core.theme
    echo "Cleaning . . ."
    sudo apt purge ubuntu-mate-welcome gnome-keyring blueman -y &> /dev/null
    sudo apt autoremove -y
    sudo apt autoclean -y
	echo "ZED is prepared to build"
fi
