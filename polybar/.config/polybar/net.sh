#!/usr/bin/env bash

# Verifica se está conectado via wifi
if iwgetid -r >/dev/null 2>&1; then
    ssid=$(iwgetid -r)
    # Extrai a qualidade do sinal
    qual=$(cat /proc/net/wireless | awk 'NR==3 {print int($3)}')
    
    if [ -z "$qual" ]; then
        icon=""
    elif [ "$qual" -ge 55 ]; then
        icon="󰤨" # 4 bars
    elif [ "$qual" -ge 40 ]; then
        icon="󰤥" # 3 bars
    elif [ "$qual" -ge 25 ]; then
        icon="󰤢" # 2 bars
    elif [ "$qual" -ge 10 ]; then
        icon="󰤟" # 1 bar
    else
        icon="󰤯" # 0 bars
    fi
    
    echo "$ssid $icon"
else
    # Verifica rede cabeada
    eth=$(ip -br a | awk -F'[ /]+' '$2=="UP" && $1!="lo" {print "ETH "$3}' | head -n 1)
    if [ -n "$eth" ]; then
        echo "$eth 󰈀"
    fi
fi
