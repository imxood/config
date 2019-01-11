#!/bin/bash
set -e

# remove not need software
sudo apt autoremove -y firefox thunderbird

# tools
sudo apt install -y vim chromium-browser git make cmake openjdk-8-jdk openocd supervisor python3 python3-pip curl polipo shadowsocks net-tools fcitx-googlepinyin lftp xclip aria2 fish

# swap tool
sudo apt install -y dphys-swapfile

sudo sh -c "echo CONF_SWAPSIZE=1024" >> /etc/dphys-swapfile

sudo systemctl restart dphys-swapfile.service

# chinese language package
sudo apt install -y language-pack-zh-han*

# aria2
sudo apt install -y aria2
if [ ! -f "/etc/aria2.conf" ]; then
	sudo wget --show-progress https://raw.githubusercontent.com/imxood/config/master/etc/aria2.conf -N -P /etc/
	sudo wget --show-progress https://raw.githubusercontent.com/imxood/config/master/etc/supervisor/conf.d/aria2c.conf -N -P /etc/supervisor/conf.d/
fi


# update pip3, set tsinghua mirror
sudo pip install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# develop tools
sudo apt install global libncurses5-dev libncursesw5-dev -y

# web proxy
if [ ! -f "/etc/polipo/config" ]; then
	sudo wget --show-progress https://raw.githubusercontent.com/imxood/config/master/etc/polipo/config -N -P /etc/polipo/
	sudo service polipo restart
fi

# socket5 proxy
if [ ! -f "/etc/supervisor/conf.d/ss-client.conf" ]; then
        sudo wget --show-progress https://raw.githubusercontent.com/imxood/config/master/etc/supervisor/conf.d/ss-client.conf -N -P /etc/supervisor/conf.d/
fi

if [ ! -f "/etc/ss-client.json" ]; then
	sudo wget --show-progress https://github.com/imxood/config/raw/master/etc/ss-client.json -N -P /etc
fi

sudo supervisorctl reload

# Install vscode
if [ ! -f /usr/bin/code ]; then
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	rm microsoft.gpg

	sudo apt update && sudo apt install code
fi

# sudo apt install -y libnvidia-compute-415 libnvidia-compute-415 libnvidia-gl-415 nvidia-utils-415 xserver-xorg-video-nvidia-415 libnvidia-cfg1-415 libnvidia-ifr1-415

# Install nvidia driver
sudo apt install nvidia-390 -y

# Install qt5
sudo apt install -y qtcreator

# Install documentation and examples
sudo apt install -y qt5-doc qt5-doc-html qtbase5-examples qtbase5-doc-html

