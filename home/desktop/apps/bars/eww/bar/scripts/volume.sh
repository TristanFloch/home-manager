#!/bin/sh

select_icon() {
    if [ "$lvl" = "0" ]; then
        icon="󰕿"
    elif [ "$lvl" = "1" ]; then
        icon="󰖀"
    else
        icon="󰕾"
    fi
}

output() {
    lvl=$(awk -v n="$(vol "SINK")" 'BEGIN{print int(n/34)}')
    ismuted=$(ismuted "SINK")

    if [ "$ismuted" = 1 ]; then
        select_icon
    else
        icon="󰖁"
    fi

    printf '{ "icon": "%s", "percent": "%s", "microphone": "%s" }\n' \
        "$icon" "$(vol "SINK")" "$(vol "SOURCE")"
}

vol() {
    wpctl get-volume "@DEFAULT_AUDIO_$1@" | awk '{print int($2*100)}'
}

ismuted() {
    wpctl get-volume "@DEFAULT_AUDIO_$1@" | rg -i muted
    echo "$?"
}

setvol() {
    wpctl set-volume "@DEFAULT_AUDIO_$1@" "$(awk -v n="$2" 'BEGIN{print (n / 100)}')"
}

setmute() {
    wpctl set-mute "@DEFAULT_AUDIO_$1@" toggle
}

if [ "$1" = "mute" ]; then
    if [ "$2" != "SOURCE" ] && [ "$2" != "SINK" ]; then
        echo "Can only mute SINK or SOURCE"; exit 1
    fi
    setmute "$2"
elif [ "$1" = "setvol" ]; then
    if [ "$2" != "SOURCE" ] && [ "$2" != "SINK" ]; then
        echo "Can only set volume for SINK or SOURCE"; exit 1
    elif [ "$3" -lt 1 ] || [ "$3" -gt 100 ]; then
        echo "Volume must be between 1 and 100"; exit 1
    fi
    setvol "$2" "$3"
else
    # initial values
    output

    # event loop
    pactl subscribe | rg --line-buffered "change" | while read -r _; do
        output
    done
fi
