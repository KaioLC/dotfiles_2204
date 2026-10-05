#!/usr/bin/env bash

# Procura por uma bateria
BAT=$(ls -1 /sys/class/power_supply/ 2>/dev/null | grep -i bat | head -n 1)

if [ -z "$BAT" ]; then
    # Se não existe bateria (Desktop PC), mostra apenas o ícone de energia
    echo "󰚥 POWERED"
    exit 0
fi

# Lê o status e a capacidade da bateria
STATUS=$(cat /sys/class/power_supply/$BAT/status 2>/dev/null)
CAPACITY=$(cat /sys/class/power_supply/$BAT/capacity 2>/dev/null)

if [ -z "$STATUS" ] || [ -z "$CAPACITY" ]; then
    echo "󰚥 POWERED"
    exit 0
fi

if [ "$STATUS" = "Charging" ]; then
    if [ "$CAPACITY" -ge 90 ]; then ICON="󰂅"
    elif [ "$CAPACITY" -ge 80 ]; then ICON="󰂋"
    elif [ "$CAPACITY" -ge 70 ]; then ICON="󰂊"
    elif [ "$CAPACITY" -ge 60 ]; then ICON="󰢞"
    elif [ "$CAPACITY" -ge 50 ]; then ICON="󰂉"
    elif [ "$CAPACITY" -ge 40 ]; then ICON="󰢝"
    elif [ "$CAPACITY" -ge 30 ]; then ICON="󰂈"
    elif [ "$CAPACITY" -ge 20 ]; then ICON="󰂇"
    elif [ "$CAPACITY" -ge 10 ]; then ICON="󰂆"
    else ICON="󰢜"
    fi
    echo "$ICON $CAPACITY%"
elif [ "$STATUS" = "Discharging" ]; then
    if [ "$CAPACITY" -ge 95 ]; then ICON="󰁹"
    elif [ "$CAPACITY" -ge 90 ]; then ICON="󰂂"
    elif [ "$CAPACITY" -ge 80 ]; then ICON="󰂁"
    elif [ "$CAPACITY" -ge 70 ]; then ICON="󰂀"
    elif [ "$CAPACITY" -ge 60 ]; then ICON="󰁿"
    elif [ "$CAPACITY" -ge 50 ]; then ICON="󰁾"
    elif [ "$CAPACITY" -ge 40 ]; then ICON="󰁽"
    elif [ "$CAPACITY" -ge 30 ]; then ICON="󰁼"
    elif [ "$CAPACITY" -ge 20 ]; then ICON="󰁻"
    elif [ "$CAPACITY" -ge 10 ]; then ICON="󰁺"
    else ICON="󰂎"
    fi
    echo "$ICON $CAPACITY%"
else
    # Status "Full" ou "Not charging" (geralmente em 100%)
    echo "󰚥 $CAPACITY%"
fi
