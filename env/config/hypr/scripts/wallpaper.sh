#!/usr/bin/env bash
wdir="${WALLPAPERS_DIR:-$(xdg-user-dir PICTURES)}"

set_random() {
	w="$(find $wdir -type f -iname '*.jpg' -o -iname '*.png' -o  -iname '*.jpeg' | shuf -n 1)"

	hyprctl hyprpaper wallpaper ",$w,cover"
}

case "$1" in
	-n | --next)
		set_random
		exit 0
		;;
	-d | --daemon)
		while true; do
			sleep 3600
			set_random
		done &
		;;
	*)
		echo "
usage: $(basename $0) (-n | --next)
       $(basename $0) (-d | --daemon)
"
		exit 1
		;;
esac


