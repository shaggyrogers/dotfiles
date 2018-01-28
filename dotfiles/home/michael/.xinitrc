#!/bin/sh
#Changes X settings. Executed by xinit when logging in.                   

/home/michael/.xsessionrc

#Run i3 (if it isn't already running)
if ! pgrep "i3$"; then
    exec i3
fi

exit 0
