#!/usr/bin/env bash
LANG=C
is_active() {
	pgrep -x pw-loopback > /dev/null
}

is_muted() {
	pamixer --default-source --get-mute
}

print_status() {
    local text_output alt_text tooltip_text


	if [[ $(is_muted) = "true" ]]; then
		text_output="󰍭"
		alt_text="muted"
		tooltip_text=" <b>Monitor do microfone</b>\n"
		tooltip_text+="<i>Microfone mudo</i>\n"
		tooltip_text+="󰀨  󰍽² para ativar"
	else
		if is_active; then
			text_output=""
			alt_text="on"
			tooltip_text=" <b>Monitor do microfone</b>\n"
			tooltip_text+="<i>Ouvindo o microfone</i>\n"
			tooltip_text+="󰀨  󰍽²  para desativar"
		else
			text_output=""
			alt_text="off"
			tooltip_text=" <b>Monitor do microfone</b>\n"
			tooltip_text+="<i>Desativado</i>\n"
			tooltip_text+="󰀨  󰍽²  para ouvir"
		fi
	fi
    cat <<JSON
{"text":"$text_output", "alt":"$alt_text", "tooltip":"$tooltip_text"}
JSON
}

case $1 in
	-s | --status)
		print_status
		exit 0
		;;
	-t | --toggle)
		if is_active; then
			pkill -x pw-loopback
		else
			[[ $(is_muted) = false ]] || pamixer --default-source --unmute
			pw-loopback & > /dev/null 2>&1
		fi
		exit 0
		;;
	-d | --disable)
		pkill -9 -x pw-loopback
		;;
	*)
		echo "
usage: $(basename $0) (-t | --toggle)
       $(basename $0) (-d | --disable)
       $(basename $0) (-s | --status)
"
		exit 1
		;;
esac
