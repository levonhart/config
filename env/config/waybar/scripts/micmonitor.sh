#!/usr/bin/env bash
LANG=C
is_active() {
	pgrep -x pw-loopback > /dev/null
}

print_status() {
    local text_output alt_text tooltip_text

    if is_active; then
        text_output=""
        alt_text="on"
		tooltip_text=" <b>Monitor do microfone</b>\n"
		tooltip_text+="Ouvindo o microfone\n"
		tooltip_text+="<i>󰀨  clique para desativar</i>"
	else
        text_output=""
        alt_text="off"
		tooltip_text=" <b>Monitor do microfone</b>\n"
		tooltip_text+="Desativado\n"
		tooltip_text+="<i>󰀨  clique para ouvir</i>"
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
