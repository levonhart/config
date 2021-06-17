#!/usr/bin/env bash

#genmon script for minimizing the active window

WINDOW_TITLE=$(xdotool getactivewindow getwindowname)
NUMBER_OF_OPENED_WINDOWS=$(wmctrl -l | wc -l)

INFO="<txt>"
INFO+="<span font_family='FiraCode Nerd Font Mono' weight='Regular' fgcolor='#DFDFDF'>" 
if [ "${NUMBER_OF_OPENED_WINDOWS}" -gt 2 ] && [ "${WINDOW_TITLE}" != "Desktop" -a "${WINDOW_TITLE}" != ""   ]; then # hide the minimize button when the active window becomes Desktop
    INFO+="类"
# else
#     INFO+=""
fi
INFO+="</span>"
INFO+="</txt>"
if [ "${NUMBER_OF_OPENED_WINDOWS}" -gt 2 ] && [ "${WINDOW_TITLE}" != "Desktop" -a "${WINDOW_TITLE}" != ""  ]; then # we dont want to hide the desktop; it'll crash everything
 INFO+="<txtclick>wmctrl -ir $(xdotool getactivewindow) -b toggle,maximized_vert,maximized_horz</txtclick>"
fi
echo -e "${INFO}"

MORE_INFO="<tool>"
MORE_INFO+="${NULL_VALUE}" #to hide the tooltip
MORE_INFO+="</tool>"

echo -e "${MORE_INFO}"
