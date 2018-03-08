#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
	cd FILES
    sudo apt update
	sudo apt install xclip xfwm4 xscreensaver xscreensaver-data python-pyaudio shutter gambas3 mplayer ubuntu-mate-core ubuntu-mate-desktop lightdm lightdm-gtk-greeter ubuntu-artwork devilspie -y
    sudo dpkg -i *.deb
    sudo apt install -f -y
	rm -rf /usr/share/backgraunds
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
    echo "Cleaning . . ."
    sudo apt purge ubuntu-mate-welcome gnome-keyring blueman -y &> /dev/null
    sudo apt autoremove -y
    sudo apt autoclean -y
	echo "ZED is prepared to build"
	echo "To Build the ISO use Pinguy Builder"
fi
