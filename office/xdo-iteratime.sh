#!/bin/bash

LATENCY=0.5
LATENCYLONG=2
PACKAGE='DB-BahnDirekt-2018_EXT - DevOps'
COMMENT='OpenShift @ DB'

setxkbmap

daycount=$1

function keytab {
  sleep $LATENCY
  xdotool key "Tab"
}

function keyreturn {
  sleep $LATENCY
  xdotool key "Return"
}

function typetab {
  sleep $LATENCY
  xdotool type "$1"
  keytab
}

function typewaittab {
  sleep $LATENCYLONG
  xdotool type "$1"
  sleep $LATENCYLONG
  keytab
}

function cr {
  for i in {1..5}; do
    sleep $LATENCY
    xdotool key "Shift+Tab"
  done
  keyreturn
}

function nextentry {
  cr
  for i in {1..3}; do
    sleep $LATENCY
    keyreturn
  done
}

function fillDay {
  typetab "09:00"
  typetab "12:00"
  keytab
  typewaittab "$PACKAGE"
  typetab "$COMMENT"
  cr
  typetab "13:00"
  typetab "18:00"
  keytab
  typewaittab "$PACKAGE"
  typetab "$COMMENT"
  nextentry
}

WID=$(xdotool search firefox | tail -n1)
xdotool windowactivate $WID

for i in $(seq 1 "$daycount"); do
  fillDay
done
