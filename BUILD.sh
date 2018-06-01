#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
    echo "Updating system"
    sudo apt update
    sudo apt upgrade -y
    echo "Installing dependenices"
	cd FILES
    sudo add-apt-repository ppa:gambas-team/gambas3 -y
    sudo apt update
	for i in build-essential g++ automake autoconf libtool libbz2-dev libmysqlclient-dev unixodbc-dev libpq-dev postgresql-server-dev-10 libsqlite0-dev libsqlite3-dev libglib2.0-dev libgtk2.0-dev libcurl4-gnutls-dev libgtkglext1-dev libpcre3-dev libsdl-sound1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev libsage-dev libxml2-dev libxslt1-dev librsvg2-dev libpoppler-dev libpoppler-glib-dev libpoppler-private-dev libasound2-dev libesd0-dev libdirectfb-dev libxtst-dev libffi-dev libqt4-dev libqtwebkit-dev libqt4-opengl-dev libglew-dev libimlib2-dev libv4l-dev libsdl-ttf2.0-dev libgnome-keyring-dev libgdk-pixbuf2.0-dev linux-libc-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libcairo2-dev libgsl-dev libncurses5-dev libgmime-2.6-dev llvm-dev llvm libalure-dev libgmp-dev libgtk-3-dev libsdl2-dev libsdl2-mixer-dev libsdl2-ttf-dev libsdl2-image-dev sane-utils libdumb1-dev libssl-dev libaudiofile-dev libqt5opengl5-dev libqt5svg5-dev libqt5webkit5-dev libqt5x11extras5-dev qtbase5-dev xclip xfwm4 xscreensaver xscreensaver-data python-pyaudio shutter mplayer ubuntu-mate-core ubuntu-mate-desktop lightdm lightdm-gtk-greeter ubuntu-artwork devilspie libboost1.62-all-dev libavdevice-dev libjemalloc1 libspnav0 npm; do
	  sudo apt-get install $i -y
	done
    sudo dpkg -i *.deb
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
