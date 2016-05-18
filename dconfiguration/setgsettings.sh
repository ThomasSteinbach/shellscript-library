#!/bin/bash

# configure launcher
gsettings set com.canonical.Unity.Launcher favorites "['application://org.gnome.Nautilus.desktop', 'application://google-chrome.desktop', 'application://atom.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

# natural scrolling of touchpad
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true

# input language
gsettings set org.gnome.desktop.input-sources current 0
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'de')]"

# set 4x4 workspaces
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 2
