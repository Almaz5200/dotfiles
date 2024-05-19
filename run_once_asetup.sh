#!/bin/bash

# Check OS
if [ "$(uname)" == "Darwin" ]; then
	# Mac OS X platform
	sh ~/.local/share/chezmoi/ensure_ansible_macos.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	# GNU/Linux platform
	sh ~/.local/share/chezmoi/ensure_ansible_debian.sh
fi

mkdir -p ~/playbooks/

if [ ! -f ~/playbooks/ansible-password ]; then
	cd ~/playbooks/
	echo "Enter your ansible vault password"
	read -s password
	echo $password >ansible-password
	chmod 600 ansible-password
	echo "Ansible-password file created"
fi
