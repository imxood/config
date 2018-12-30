#!/bin/bash
set -e

sudo apt autoremove -y firefox

sudo apt install -y vim chromium-browser git make cmake openjdk-8-jdk openocd supervisor python3 python3-pip curl polipo shadowsocks net-tools fcitx-googlepinyin lftp

# update pip3, set tsinghua mirror
pip install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

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

# install vscode
if [ ! -f /usr/bin/code ]; then
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	rm microsoft.gpg

	sudo apt update && sudo apt install code
fi
