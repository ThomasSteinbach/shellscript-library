#!/bin/bash
cd /etc/ansible/roles
rm -rf thomass.common thomass.docker thomass.java thomass.mysql thomass.nodejs thomass.playbook2dockerimage
cd /home/thomass/git/thomass_ansible_roles
cp -a thomass.common thomass.docker thomass.java thomass.mysql thomass.nodejs thomass.playbook2dockerimage /etc/ansible/roles
cd /etc/ansible/roles
git status
