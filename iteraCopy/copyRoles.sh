#!/bin/bash
cd "$2"
rm -rf thomass.common thomass.docker thomass.java thomass.mysql thomass.mysql_connector thomass.nodejs thomass.playbook2dockerimage thomass.gradle thomass.install_docker_daemon thomass.ruby
cd "$1"
cp -a thomass.common thomass.docker thomass.java thomass.mysql thomass.mysql_connector thomass.nodejs thomass.playbook2dockerimage thomass.gradle thomass.install_docker_service thomass.ruby "$2"
cd "$2"
git status
