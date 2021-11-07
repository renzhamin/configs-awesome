#!/bin/sh

run() {
    [ $(pgrep -u ${USER} ${1}) ] || ${1} &
}

nitrogen --restore
xinput float 17
xmodmap -e 'keycode 108=Escape'
run picom
run lxpolkit 
run /usr/lib/geoclue-2.0/demos/agent
run redshift
# brave &
