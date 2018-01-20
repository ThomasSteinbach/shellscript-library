#!/bin/bash

#
# This script streams the output of 'ps aux' into a file named 'ramusage' and replaces
# all PIDs of processes within docker containers with the name of the container.
#

ps aux --sort=-%mem | awk '{printf "%-30s %-10s %-10s %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$2,$4,$9,$10,$11,$12,$13,$14,$15,$16,$17}' > ramusage

for name in $(sudo docker ps --format "{{ .Names }}"); do
        for pid in $(sudo docker top $name -eo pid | tail -n +2); do
                fname=$(echo $name | awk '{printf "%-31s", $1}')
                sed -i "s/$pid\s*/$fname/g" ramusage;
        done;
done
