#!/bin/bash

# Check for Ansible
if test ! $(which ansible); then
	echo "Installing ansible..."
	sudo apt update
	sudo apt install software-properties-common -y
	sudo apt-add-repository --yes --update ppa:ansible/ansible
	sudo apt install ansible -y
else
	echo "Ansible is already installed"
fi

# Check for Pass
if test ! $(which pass); then
	echo "Installing pass..."
	sudo apt update
	sudo apt install pass -y
else
	echo "Pass is already installed"
fi
