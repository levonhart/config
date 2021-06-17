#!/usr/bin/env bash

#genmon script for closing the active window

WINDOW_TITLE=$(xdotool getactivewindow getwindowname)
NUMBER_OF_OPENED_WINDOWS=$(wmctrl -l | wc -l)

INFO="<txt>"
INFO+="<span font_family='FiraCode Nerd Font Mono' weight='Regular' fgcolor='#DFDFDF'>" 
if [ "${NUMBER_OF_OPENED_WINDOWS}" -gt 2 ] && [ "${WINDOW_TITLE}" != "Desktop" -a "${WINDOW_TITLE}" != "" ]; then # hide the close button when the active window becomes Desktop
    INFO+=""
# else
#     INFO+=""
fi
INFO+="</span>"
INFO+="</txt>"
if [ "${NUMBER_OF_OPENED_WINDOWS}" -gt 2 ] && [ "${WINDOW_TITLE}" != "Desktop" -a "${WINDOW_TITLE}" != ""  ]; then # we dont want to hide the desktop; it'll crash everything
 # INFO+="<txtclick>xdotool windowkill `xdotool getactivewindow`</txtclick>"
 INFO+="<txtclick>xdotool key 'Super_L+q'</txtclick>"
fi
echo -e "${INFO}"

MORE_INFO="<tool>"
MORE_INFO+="${NULL_VALUE}" #just to hide the tooltip
MORE_INFO+="</tool>"

echo -e "${MORE_INFO}"
