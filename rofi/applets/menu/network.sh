#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

style="$($HOME/.config/rofi/applets/menu/style.sh)"

dir="$HOME/.config/rofi/applets/menu/configs/$style"
rofi_command="rofi -theme $dir/network.rasi"

## Get info
IFACE="$(nmcli | grep -i interface | awk '/interface/ {print $2}')"
#SSID="$(iwgetid -r)"
#LIP="$(nmcli | grep -i server | awk '/server/ {print $2}')"
#PIP="$(dig +short myip.opendns.com @resolver1.opendns.com )"
STATUS="$(nmcli radio wifi)"

active=""
urgent=""

if (ping -c 1 google.com || ping -c 1 github.com || ping -c 1 archlinux.org) &>/dev/null; then
	if [[ $STATUS == *"enable"* ]]; then
        if [[ $IFACE == e* ]]; then
            connected=""
        else
            connected=""
        fi
	active="-a 0"
	SSID="﬉ $(nmcli -t -f name connection show --active | awk 'NR==1')"
	PIP="$(wget --timeout=1 http://ipinfo.io/ip -qO -)"
	fi
else
    urgent="-u 0"
    SSID="Desconectado"
    PIP="Indisponível"
    connected=""
fi

## Icons
bmon=""
launch_cli=""
launch=""

options="$connected\n$bmon\n$launch_cli\n$launch"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$SSID  :  $PIP" -dmenu $active $urgent -selected-row 1)"
case $chosen in
    $connected)
		if [[ $STATUS == *"enable"* ]]; then
			nmcli radio wifi off
		else
			nmcli radio wifi on
		fi 
        ;;
    $bmon)
        xfce4-terminal -e bmon
        ;;
    $launch_cli)
        xfce4-terminal -e nmtui
        ;;
    $launch)
        gnome-control-center network
        ;;
esac

