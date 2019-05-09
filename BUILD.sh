#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
else
	echo "Installing dependenices"
	cd FILES
	add-apt-repository ppa:gambas-team/gambas3 -y
	apt update
	for i in libopenvdb-dev htop libpq-dev build-essential g++ automake autoconf libtool libbz2-dev libmysqlclient-dev unixodbc-dev libpq-dev libsqlite0-dev libsqlite3-dev libglib2.0-dev libgtk2.0-dev libcurl4-gnutls-dev libgtkglext1-dev libpcre3-dev libsdl-sound1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev libsage-dev libxml2-dev libxslt1-dev librsvg2-dev libpoppler-dev libpoppler-glib-dev libpoppler-private-dev libasound2-dev libesd0-dev libdirectfb-dev libxtst-dev libffi-dev libqt4-dev libqtwebkit-dev libqt4-opengl-dev libglew-dev libimlib2-dev libv4l-dev libsdl-ttf2.0-dev libgnome-keyring-dev libgdk-pixbuf2.0-dev linux-libc-dev libcairo2-dev libgsl-dev libncurses5-dev libgmime-2.6-dev llvm-dev llvm libalure-dev libgmp-dev libgtk-3-dev libsdl2-dev libsdl2-mixer-dev libsdl2-ttf-dev libsdl2-image-dev sane-utils libdumb1-dev libssl-dev libaudiofile-dev libqt5opengl5-dev libqt5svg5-dev libqt5webkit5-dev libqt5x11extras5-dev qtbase5-dev xclip xfwm4 xscreensaver xscreensaver-data python-pyaudio shutter mplayer ubuntu-mate-core ubuntu-mate-desktop lightdm lightdm-gtk-greeter devilspie libboost1.62-all-dev libavdevice-dev libjemalloc1 libspnav0 python-pip npm; do
		apt install $i -y
	done
	dpkg -i *.deb
	apt install -f -y
	npm install electron -g
	rm -rf /usr/share/backgraunds
	apt install gambas3 -y
	cd ..
	echo "Downloading ZED OS Files"
	git clone https://github.com/ZEDOSPROJECT/ZED-ROOT-OS.git
	echo "Installing ZED OS Files"
	cd ZED-ROOT-OS
	rm -rf .git
	cp -Rf . /
	cd ..
	rm -rf ZED-ROOT-OS
	chmod +x -R /sbin
	update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/zed/zed.plymouth 100
	echo "Select ZED OS Plymouth afther press ENTER"
	read
	update-alternatives --config default.plymouth
	update-initramfs -u
	update-alternatives --set x-cursor-theme /etc/X11/cursors/core.theme
	chmod 777 -R /etc/skel/
	chmod 777 -R /usr/share/themes
	echo "Updating system"
	apt update
	apt upgrade -y
	echo "Cleaning . . ."
	rm /etc/skel/Desktop/.noremove
	rm /etc/skel/Documents/.noremove
	rm /etc/skel/Downloads/.noremove
	rm /etc/skel/Music/.noremove
	rm /etc/skel/Pictures/.noremove	
	rm /etc/skel/Public/.noremove
	rm /etc/skel/Templates/.noremove
	rm /etc/skel/Videos/.noremove	
	rn /etc/skel/.config/zed/.noremove	
	apt purge ubuntu-mate-welcome firefox* libreoffice* blueman -y &> /dev/null
	apt autoremove -y
	apt autoclean -y
	echo "ZED is prepared to build"
fi
