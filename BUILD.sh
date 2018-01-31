#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
	cd FILES
	echo "Installing necessary packages"
	sudo dpkg -i pinguybuilder.deb &> /dev/null
	sudo apt-get install -f -y &> /dev/null
	sudo dpkg -i masalla_0.9_all.deb &> /dev/null
	sudo apt-get install -f -y &> /dev/null
    	sudo dpkg -i indicator-keylock_3.1.0_amd64.deb &> /dev/null
    	sudo apt-get install -f -y &> /dev/null
	sudo apt install xclip xfwm4 xscreensaver xscreensaver-data python-pyaudio shutter gambas3 mplayer ubuntu-mate-core ubuntu-mate-desktop lightdm lightdm-gtk-greeter ubuntu-artwork  -y &> /dev/null
	rm -rf /usr/share/backgraunds
	clear
	echo "Downloading ZED OS Files"
	wget https://zedfiles.blob.core.windows.net/updates/update.tar.gz
	echo "Installing ZED OS Files"
	tar -zxvf update.tar.gz -C / &> /dev/null
	rm -zxvf update.tar.gz
    	sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/zed/zed.plymouth 100
	echo "Select ZED OS Plymouth afther press ENTER"
	read
	sudo update-alternatives --config default.plymouth
	sudo update-initramfs -u
	clear
	echo "ZED is prepared to build"
	echo "To Build the ISO use Pinguy Builder"
fi

