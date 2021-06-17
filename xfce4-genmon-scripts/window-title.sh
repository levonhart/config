#!/usr/bin/env bash

#genmon script for displaying the active window title on the panel

WINDOW_TITLE=$(xdotool getactivewindow getwindowname | cut -c -65 | sed -e 's/\"/\\\"/g' -e "s/'/\\'/g" ) #truncating active window title after 60chars
NUMBER_OF_OPENED_WINDOWS=$(wmctrl -l | wc -l)
LENGTH_OF_TITLE=$(echo ${WINDOW_TITLE})

INFO="<txt>"
INFO+="<span font_family='Fira Sans' weight='Medium' fgcolor='#DFDFDF'>" 
# INFO+=" ${WINDOW_TITLE:-} "
INFO+="${WINDOW_TITLE:-}"
if [ "${LENGTH_OF_TITLE}" -gt 64 ]; then
    INFO+="..."
fi
INFO+="</span>"
INFO+="</txt>"
if [ -n "${WINDOW_TITLE}" -a "${NUMBER_OF_OPENED_WINDOWS}" -gt 2 ]; then #find the optimum number of opened up windows at startup. I've set 3 since its XFCE4-Panel, Plank and Desktop. 
 INFO+="<txtclick>rofi -combi-modi window -show window -icon-theme "Papirus" -show-icons</txtclick>"
fi
echo -e "${INFO}"

MORE_INFO="<tool>"
MORE_INFO+="${NULL_VALUE}"  #to hide the tooltip
MORE_INFO+="</tool>"

echo -e "${MORE_INFO}"
