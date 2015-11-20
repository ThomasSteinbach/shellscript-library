#!/bin/bash
cd ~
git clone git://github.com/ansible/ansible.git --recursive
sudo apt-get install python-pip
sudo pip install --upgrade paramiko PyYAML Jinja2 httplib2 six docker-py
echo "source ~/ansible/hacking/env-setup -q" >> ~/.bashrc
source ~/ansible/hacking/env-setup -q
echo "Ansible installed:"
ansible --version
