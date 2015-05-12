#!/bin/bash
cd /home/thomass/git/thomass_ansible_roles
rm -rf thomass.common thomass.docker thomass.java thomass.mysql thomass.nodejs thomass.playbook2dockerimage
cd /etc/ansible/roles
cp -a thomass.common thomass.docker thomass.java thomass.mysql thomass.nodejs thomass.playbook2dockerimage /home/thomass/git/thomass_ansible_roles
cd /home/thomass/git/thomass_ansible_roles
git status
