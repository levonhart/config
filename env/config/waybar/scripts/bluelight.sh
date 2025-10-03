#!/usr/bin/env bash

default_temp=6500
default_gamma=100
temp=(5500 3000)
gamma=(80 40)

get_temp() {
    hyprctl hyprsunset temperature 2>/dev/null || echo "$default_temp"
}
get_gamma() {
    hyprctl hyprsunset gamma 2>/dev/null || echo "$default_gamma"
}

is_active() {
	[[ "$(hyprctl hyprsunset gamma)" != $default_gamma ]]
}

print_status() {
    local alt_text current_temp tooltip_text gamma

    # Get current running temperature
    current_temp=$(get_temp)

    if ! is_active; then
        text_output=""
        alt_text="day"

		tooltip_text="󰈈 <b>Filtro de luz azul (desativado)</b>\n"
		tooltip_text+=" ${default_temp} K"
		tooltip_text+="\t\t\t\t "
		tooltip_text+=" ${default_gamma}%\n"
		tooltip_text+="󰀨 <i>clique para ativar o modo noite</i>"
	elif [[ $current_temp = ${temp[0]} ]]; then
        text_output="󰈈"
        alt_text="evening"
        gamma=$(get_gamma)

		tooltip_text="󰈈 <b>Filtro de luz azul (noite)</b>\n"
		tooltip_text+=" ${current_temp} K"
		tooltip_text+="\t\t\t"
		tooltip_text+=" ${gamma}%\n"
		tooltip_text+="󰀨 <i>clique p/ modo madrugada</i>"
    else
        text_output="󰈈"
        alt_text="midnight"
        gamma=$(get_gamma)

		tooltip_text="󰈈 <b>Filtro de luz azul (madrugada)</b>\n"
		tooltip_text+=" ${current_temp} K"
		tooltip_text+="\t\t\t\t   "
		tooltip_text+=" ${gamma}%\n"
		tooltip_text+="󰀨 <i>clique para desativar</i>"
    fi
    cat <<JSON
{"text":"$text_output", "alt":"$alt_text", "tooltip":"$tooltip_text" }
JSON
}

case "$1" in
	-t | --toggle)
		if is_active; then
			hyprctl hyprsunset temperature $default_temp
			hyprctl hyprsunset gamma $default_gamma
		else
			hyprctl hyprsunset temperature ${temp[0]}
			hyprctl hyprsunset gamma ${gamma[0]}
		fi
		exit 0
		;;
	-n | --next)
		if ! is_active; then
			hyprctl hyprsunset temperature ${temp[0]}
			hyprctl hyprsunset gamma ${gamma[0]}
		elif [[ "$(get_temp)" = ${temp[0]} ]]; then
			hyprctl hyprsunset temperature ${temp[1]}
			hyprctl hyprsunset gamma ${gamma[1]}
		else
			hyprctl hyprsunset temperature $default_temp
			hyprctl hyprsunset gamma $default_gamma
		fi
		exit 0
		;;
	-r | --reset)
		hyprctl hyprsunset identity
		hyprctl hyprsunset gamma $default_gamma
		exit 0
		;;
	-s | --status)
		print_status
		exit 0
		;;
	*)
		echo "
usage: $(basename $0) (-t | --toggle)
       $(basename $0) (-n | --next)
       $(basename $0) (-s | --status)
       $(basename $0) (-r | --reset)
"
		exit 1
		;;
esac
