#!/usr/bin/env bash

if [[ $(hyprctl monitors | grep -c 'HDMI-A-1') -eq 1 ]]; then
    hyprctl keyword monitor 'HDMI-A-1, 1920x1080@75, 0x0, 1'
    hyprctl keyword monitor 'eDP-1, disable'
else
    hyprctl keyword monitor 'eDP-1, 1366x768@60, 0x0, 1'
fi

function handle {
	if [[ "$USE_LAPTOP_MONITOR" -eq 1 ]]; then
			hyprctl keyword monitor 'eDP-1, 1366x768@60, auto, 1'
	fi
	if [[ ${1:0:12} == 'monitoradded' ]]; then
		if [[ ${1:14:8} == 'HDMI-A-1' ]]; then
			hyprctl keyword monitor 'HDMI-A-1, 1920x1080@75, 0x0, 1'
			hyprctl keyword monitor 'eDP-1, disable'
		fi
	elif [[ ${1:0:14} == 'monitorremoved' ]]; then
		if [[ ${1:16:8} == 'HDMI-A-1' ]]; then
			hyprctl keyword monitor 'eDP-1, 1366x768@60, auto, 1'
		fi
	elif [[ ${1:0:10} == 'focusedmon' ]]; then
		if [[ ${1:12:8} == 'HDMI-A-1' ]]; then
			hyprctl keyword monitor 'HDMI-A-1, 1920x1080@75, 0x0, 1'
			hyprctl keyword monitor 'eDP-1, disable'
		fi
	fi
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
